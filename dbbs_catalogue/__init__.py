"""
DBBS NMODL Catalogue

NMODL Mechanism collection of the DBBS laboratory of the University of Pavia

Glia asset bundle. If the Glia Asset Manager (`nmodl-glia`) is installed, the NMODL assets
in this package will automatically be available in your Glia library for use in the Arbor
and NEURON brain simulation engines.
"""
from pathlib import Path
from glia import Package, Mod

__version__ = "0.1.0"
package = Package(
    "dbbs",
    Path(__file__).resolve().parent,
    mods=[
        Mod("mods/arbor/Ca__0.mod", "Ca", dialect="arbor"),
        Mod("mods/arbor/CaL13__0.mod", "CaL13", dialect="arbor"),
        Mod("mods/arbor/Cav2_1__0.mod", "Cav2_1", dialect="arbor"),
        Mod("mods/arbor/Cav2_2__0.mod", "Cav2_2", dialect="arbor"),
        Mod("mods/arbor/Cav2_3__0.mod", "Cav2_3", dialect="arbor"),
        Mod("mods/arbor/Cav3_1__0.mod", "Cav3_1", dialect="arbor"),
        Mod("mods/arbor/Cav3_2__0.mod", "Cav3_2", dialect="arbor"),
        Mod("mods/arbor/Cav3_3__0.mod", "Cav3_3", dialect="arbor"),
        Mod("mods/arbor/cdp5__0.mod", "cdp5", dialect="arbor"),
        Mod("mods/arbor/cdp5__CAM.mod", "cdp5", variant="CAM", dialect="arbor"),
        Mod("mods/arbor/cdp5__CAM_GoC.mod", "cdp5", variant="CAM_GoC", dialect="arbor"),
        Mod("mods/arbor/cdp5__CR.mod", "cdp5", variant="CR", dialect="arbor"),
        Mod("mods/arbor/HCN1__0.mod", "HCN1", dialect="arbor"),
        Mod("mods/arbor/HCN1__golgi.mod", "HCN1", variant="golgi", dialect="arbor"),
        Mod("mods/arbor/HCN2__0.mod", "HCN2", dialect="arbor"),
        Mod("mods/arbor/Kca1_1__0.mod", "Kca1_1", dialect="arbor"),
        Mod("mods/arbor/Kca2_2__0.mod", "Kca2_2", dialect="arbor"),
        Mod("mods/arbor/Kca3_1__0.mod", "Kca3_1", dialect="arbor"),
        Mod("mods/arbor/Kir2_3__0.mod", "Kir2_3", dialect="arbor"),
        Mod("mods/arbor/Km__0.mod", "Km", dialect="arbor"),
        Mod("mods/arbor/Kv1_1__0.mod", "Kv1_1", dialect="arbor"),
        Mod("mods/arbor/Kv1_5__0.mod", "Kv1_5", dialect="arbor"),
        Mod("mods/arbor/Kv2_2__0.mod", "Kv2_2", dialect="arbor"),
        Mod("mods/arbor/Kv3_3__0.mod", "Kv3_3", dialect="arbor"),
        Mod("mods/arbor/Kv3_4__0.mod", "Kv3_4", dialect="arbor"),
        Mod("mods/arbor/Kv4_3__0.mod", "Kv4_3", dialect="arbor"),
        Mod("mods/arbor/Kv7__0.mod", "Kv7", dialect="arbor"),
        Mod("mods/arbor/Leak__0.mod", "Leak", dialect="arbor"),
        Mod("mods/arbor/Leak__GABA.mod", "Leak", variant="GABA", dialect="arbor"),
        Mod(
            "mods/arbor/Na__granule_cell.mod",
            "Na",
            variant="granule_cell",
            dialect="arbor",
        ),
        Mod(
            "mods/arbor/Na__granule_cell_FHF.mod",
            "Na",
            variant="granule_cell_FHF",
            dialect="arbor",
        ),
        Mod("mods/arbor/Nav1_1__0.mod", "Nav1_1", dialect="arbor"),
        Mod("mods/arbor/Nav1_6__0.mod", "Nav1_6", dialect="arbor"),
    ],
)
