return function(nodemgr)
    local avSeparatorNode = table.shallow_copy(nodemgr.nodeClass)
    avSeparatorNode.title="Audio-video separator"
    avSeparatorNode.shortTitle="AV separator"
    avSeparatorNode.id="av-separator"
    avSeparatorNode.about="Node that returns both audio and video separated from an input video inputted by the user."
    avSeparatorNode.outputs={nodemgr.ioElem.avideo}
    avSeparatorNode.color={1,0.34,0.07,0.2}
    return avSeparatorNode
end
