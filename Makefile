include .env

build:
	npx quartz build -o $(OUTPUT_FOLDER)

preview:
	npx quartz build --serve

commit_quartz:
	npx quartz sync

commit_public:
	@echo "Committing build results..."
	@cd $(OUTPUT_REPO) && \
	if [ -n "$$(git status --porcelain)" ]; then \
		echo "Changes detected, committing..."; \
		git add . && \
		git commit -m $(COMMIT_MESSAGE); \
	else \
		echo "No changes to commit."; \
	fi
	@echo "Pushing to repository..."
	@cd $(OUTPUT_REPO) && \
	git push github master

deploy: build commit_public