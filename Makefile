ROOT_REPO:=jupyter/all-spark-notebook:258e25c03cba
CONTAINER_NAME:=declarativewidgets-explorer
REPO:=jupyter/declarativewidgets-explorer:258e25c03cba

define INSTALL_DECLWID_CMD
pip install --no-binary ::all: $$(ls -1 /srv/*.tar.gz | tail -n 1) && \
jupyter declarativewidgets install --user && \
jupyter declarativewidgets activate
endef

define INSTALL_DASHBOARD_CMD
pip install --no-binary ::all: jupyter_dashboards && \
jupyter dashboards install --user && \
jupyter dashboards activate
endef

init: node_modules
	@-docker $(DOCKER_OPTS) rm -f $(CONTAINER_NAME)
	@docker $(DOCKER_OPTS) run -it --user root --name $(CONTAINER_NAME) \
			-v `pwd`:/srv \
		$(ROOT_REPO) bash -c 'apt-get -qq update && \
		apt-get -qq install --yes curl && \
		curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash - && \
		apt-get -qq install --yes nodejs npm && \
		ln -s /usr/bin/nodejs /usr/bin/node && \
		npm install -g bower && \
		$(INSTALL_DECLWID_CMD) && \
		$(INSTALL_DASHBOARD_CMD)'
	@docker $(DOCKER_OPTS) commit $(CONTAINER_NAME) $(REPO)
	@-docker $(DOCKER_OPTS) rm -f $(CONTAINER_NAME)

node_modules: package.json
	@npm install --quiet

bower_components: node_modules bower.json
	@npm run bower -- install $(BOWER_OPTS)

run: PORT_MAP?=-p 8888:8888
run: CMD?=jupyter notebook --no-browser --port 8888 --ip="*"
run:
	@docker $(DOCKER_OPTS) run --user root $(OPTIONS) \
		$(PORT_MAP) \
		-e USE_HTTP=1 \
		-v `pwd`:/srv \
		-v `pwd`/elements:/root/.local/share/jupyter/nbextensions/declarativewidgets/urth_components/declarativewidgets-explorer \
		--workdir '/srv/notebooks' \
		--user root \
		$(REPO) bash -c '$(CMD)'

test: bower_components
	@bower install ../declarativewidgets/elements/urth-core-behaviors/
	@bower install ../declarativewidgets/elements/urth-viz-behaviors/
	@npm test

clean:
	@-rm -rf bower_components node_modules
