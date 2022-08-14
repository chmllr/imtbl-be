#!/bin/bash

rm -rf ./build
cp -rf ../imtbl-fe/packages/dev-frontend/build .
rm ./build/asset-manifest.json
rm -rf ./build/icons
rm ./build/robots.txt

find ./build -iname "*.map" -delete
find ./build -iname "*.txt" -delete

LINES=""

for t in "js" "css"; do
    P="build/static/$t"
    for s in $P/*; do
        gzip -n9 $s
        read -r -d '' LINE << EOT
add_asset(
        &["/${s/build\//}"],
        vec![
            ("Content-Type".to_string(), "text/${t/js/javascript}".to_string()),
            ("Content-Encoding".to_string(), "gzip".to_string()),
            ("Cache-Control".to_string(), "public".to_string()),
        ],
        include_bytes!("../../$s.gz").to_vec(),
    );
EOT
    LINES="$LINES
$LINE"
    done
done

for s in ./build/bonds/*; do
    read -r -d '' LINE << EOT
    add_asset(
        &["/${s}"],
        vec![
            ("Content-Type".to_string(), "image/png".to_string()),
            ("Cache-Control".to_string(), "public".to_string()),
        ],
        include_bytes!("../../$s").to_vec(),
    );
EOT
    LINES="$LINES
    $LINE"
done

read -r -d '' LINE << EOT
add_asset(
    &["/ic.svg"],
    vec![
        ("Content-Type".to_string(), "image/svg+xml".to_string()),
        ("Cache-Control".to_string(), "public".to_string()),
    ],
    include_bytes!("../../build/ic.svg").to_vec(),
);
EOT
LINES="$LINES
$LINE"

cat <<EOT >src/backend/asset_loader.rs
// THIS FILE IS AUTO-GENERATED BY update_assets.sh!

use crate::assets::add_asset;

pub fn load_dynamic_assets() {

$LINES

}
EOT
