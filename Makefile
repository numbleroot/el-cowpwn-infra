MANAGER=root@207.154.199.113

.PHONY: sync
sync:
	rsync -avzu --progress -h --exclude '*.git' . ${MANAGER}:swarm/

.PHONY: el-cowpwn
el-cowpwn: sync
	ssh ${MANAGER} docker stack deploy --compose-file swarm/el-cowpwn.yml el-cowpwn

.PHONY: traefik
traefik: sync
	ssh ${MANAGER} docker stack deploy --compose-file swarm/traefik.yml traefik

.PHONY: visualizer
visualizer: sync
	ssh ${MANAGER} docker stack deploy --compose-file swarm/visualizer.yml visualizer

.PHONY: visualizer-rm
visualizer-rm:
	ssh ${MANAGER} docker stack rm visualizer
