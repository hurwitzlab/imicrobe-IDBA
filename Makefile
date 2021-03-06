APP = imicrobe-idba
VERSION = 0.0.2
EMAIL = $(CYVERSEUSERNAME)@email.arizona.edu

init:
	touch rsync.exclude
	mkdir stampede
	touch stampede/app.json
	touch stampede/job.json
	touch stampede/public-job.json
	touch stampede/run.sh
	touch stampede/template.sh
	touch stampede/test.sh
	imkdir applications/$(APP)-$(VERSION)

clean:
	find . \( -name \*.conf -o -name \*.out -o -name \*.log -o -name \*.param -o -name launcher_jobfile_\* \) -exec rm {} \;

container:
	rm -f stampede/$(APP).img
	sudo singularity create --size 1000 stampede/$(APP).img
	sudo singularity bootstrap stampede/$(APP).img singularity/$(APP).def
	#sudo singularity build stampede/$(APP).img singularity/$(APP).def
	sudo chown --reference=singularity/$(APP).def stampede/$(APP).img

iput-container:
	iput -fK stampede/$(APP).img

iget-container:
	iget -fK $(APP).img
	mv $(APP).img stampede/
	irm $(APP).img

test:
	sbatch test.sh

submit-test-job:
	jobs-submit -F stampede/job.json

submit-public-test-job:
	jobs-submit -F stampede/public-job.json

files-delete:
	files-delete -f $(CYVERSEUSERNAME)/applications/$(APP)-$(VERSION)

files-upload:
	files-upload -F stampede/ $(CYVERSEUSERNAME)/applications/$(APP)-$(VERSION)

apps-addupdate:
	apps-addupdate -F stampede/app.json

deploy-app: clean files-delete files-upload apps-addupdate

share-app:
	systems-roles-addupdate -v -u <share-with-user> -r USER tacc-stampede-$(CYVERSEUSERNAME)
	apps-pems-update -v -u <share-with-user> -p READ_EXECUTE $(APP)-$(VERSION)

lytic-rsync-dry-run:
	rsync -n -arvzP --delete --exclude-from=rsync.exclude -e "ssh -A -t hpc ssh -A -t lytic" ./ :project/imicrobe/apps/imicrobe-IDBA

lytic-rsync:
	rsync -arvzP --delete --exclude-from=rsync.exclude -e "ssh -A -t hpc ssh -A -t lytic" ./ :project/imicrobe/apps/imicrobe-IDBA
