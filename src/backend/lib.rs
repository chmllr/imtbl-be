use ic_cdk_macros::*;

pub mod asset_loader;
pub mod assets;

#[init]
fn init() {
    assets::load();
}

#[post_upgrade]
fn post_upgrade() {
    assets::load();
}
