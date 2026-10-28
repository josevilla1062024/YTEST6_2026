@AccessControl.authorizationCheck: #NOT_REQUIRED
define hierarchy YCDS_FLIGHT_HIERA_26JV
  as parent child hierarchy (
    source YCDS_MOD_FLIGHT_HIER_26JV
    child to parent association _Booking
    start where BookingId is initial
    siblings order by BookingId
    multiple parents allowed
    orphans ignore
    cycles breakup
  )
{
    BookingId,
    ConnectionID,
    $node.node_id as NodeId,
    $node.hierarchy_is_cycle as HierCy,
    $node.hierarchy_is_orphan as HierOrp,
    $node.hierarchy_level as hierLev,
    $node.hierarchy_parent_rank as HierParent,
    $node.hierarchy_rank as HierRank,
    $node.hierarchy_tree_size as HierTree 
}
