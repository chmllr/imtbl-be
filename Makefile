all:
	./update_assets.sh
	dfx --identity christian deploy --network ic

status:
	dfx --identity christian canister --network ic status themis
