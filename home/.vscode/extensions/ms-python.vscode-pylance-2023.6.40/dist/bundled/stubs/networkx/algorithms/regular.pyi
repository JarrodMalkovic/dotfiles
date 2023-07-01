from ..classes.graph import Graph
from ..utils import not_implemented_for

__all__ = ["is_regular", "is_k_regular", "k_factor"]

def is_regular(G: Graph) -> bool: ...
def is_k_regular(G: Graph, k) -> bool: ...
def k_factor(G: Graph, k, matching_weight="weight"): ...