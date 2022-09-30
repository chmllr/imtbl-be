# IMTBL

IMTBL is a fully **immutable** [Liquity](https://liquity.org) frontend running on the [Internet Computer](https://internetcomputer.org). The [frontend code](https://github.com/chmllr/imtbl-fe) was forked from the official [launch kit](https://github.com/liquity/dev).

Currently, the canister is deployed with Id [vfu7d-vyaaa-aaaap-aajiq-cai](https://vfu7d-vyaaa-aaaap-aajiq-cai.ic0.app). After the canister is running, the [only controller](https://dashboard.internetcomputer.org/canister/vfu7d-vyaaa-aaaap-aajiq-cai) of the casniter will be the [blackhole](https://github.com/ninegua/ic-blackhole) canister (`e3mmv-5qaaa-aaaah-aadma-cai`), which can expose its cycle balance and enable automated top up via the [TipJar](https://k25co-pqaaa-aaaab-aaakq-cai.ic0.app) service.
No mutations will be possible to the IMTBL cansiter afterwards.

## How to Build

Before building, fetch the [frontend code](https://github.com/chmllr/imtbl-fe) into the parent directory.

Run:

    make
