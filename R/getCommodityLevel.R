##' Get Commodity Level
##' 
##' This function takes a commodity tree and provides the level of each 
##' commodity within that tree.
##' 
##' @param commodityTree A data.table with parent and child node IDs 
##'   (corresponding to the IDs in nodes) which specify the commodity tree 
##'   structure.
##' @param parentColname The column name of commodityTree which contains the ID 
##'   of the parent node.
##' @param childColname The column name of commodityTree which contains the ID 
##'   of the child node.
##' @param returnMinLevel Logical.  If a node exists at multiple processing 
##'   levels, should the minimum level be returned?  If FALSE, the maximum is
##'   returned.
##'   
##' @return A data.table with two columns: node (the ID of the commodity code) 
##'   and level.  A level of 0 indicates a top level node which is then 
##'   processed into a level 1 node.  Level 1 nodes are processed into level 2, 
##'   and so on.
##'   

getCommodityLevel = function(commodityTree, parentColname, childColname,
                             returnMinLevel = TRUE){
    
    ## Data Quality Checks
    stopifnot(is(commodityTree, "data.table"))
    stopifnot(c(parentColname, childColname) %in% colnames(commodityTree))
    
    ## Update level by first assigning nodes with no parents to level 0.  Then,
    ## assign a 1 to all nodes which currently have no level (missing) and are
    ## children of a level 0.  Proceed iteratively until no NA's are left.
    levelData = data.table(node = unique(c(commodityTree[[parentColname]],
                                           commodityTree[[childColname]])),
                           level = NA_real_)
    topNodes = setdiff(commodityTree[[parentColname]],
                       commodityTree[[childColname]])
    levelData[node %in% topNodes, level := 0]
    currentLevel = 1
    while(any(is.na(levelData$level))){
        identifiedNodes = levelData[!is.na(level), node]
        children = commodityTree[get(parentColname) %in% identifiedNodes,
                                 unique(get(childColname))]
        levelData[node %in% children & is.na(level), level := currentLevel]
        ## Nodes may exist at two levels.  If !returnMinLevel, we need to update
        ## their level to the largest of the two.
        if(!returnMinLevel){
            tempTree = copy(commodityTree)
            setnames(tempTree, parentColname, "node")
            tempTree = merge(tempTree, levelData, by = "node", all.x = TRUE)
            ## Set child level to max of parents + 1
            newLevel = tempTree[, max(level) + 1, by = childColname]
            setnames(newLevel, childColname, "node")
            levelData = merge(levelData, newLevel, by = "node", all.x = TRUE)
            levelData[!is.na(V1), level := V1]
            levelData[, V1 := NULL]
        }
        currentLevel = currentLevel + 1
    }
    levelData
}