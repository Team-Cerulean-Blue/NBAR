return function(nodemgr)
    local videoInputNode = table.shallow_copy(nodemgr.nodeClass)
    videoInputNode.title="Audio-video separator"
    videoInputNode.shortTitle="AV separator"
    videoInputNode.id="av-separator"
    videoInputNode.about="Node that returns both audio and video separated from an input video inputted by the user."
    videoInputNode.outputs={nodemgr.ioElem.avideo}
    videoInputNode.color={1,0.34,0.07,0.2}
    return avSeparatorNode
end
