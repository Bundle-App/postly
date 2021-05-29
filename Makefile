.PHONY: clean build_android build_prod_ios build deploy_prod_android deploy_prod_ios deploy_prod

clean:
	flutter clean

update_models:
	flutter pub pub run build_runner build --delete-conflicting-outputs

watch_models:
	flutter pub run build_runner watch

drive_create_post:
	flutter drive --target=test_driver/post/create.dart;