return function(nodemgr,addNode)
    local avSeparatorNode = table.shallow_copy(nodemgr.nodeClass)
    avSeparatorNode.title="Audio-video separator"
    avSeparatorNode.shortTitle="AV separator"
    avSeparatorNode.id="av-separator"
    avSeparatorNode.about="Node that returns both audio and video separated from an input video inputted by the user."
    avSeparatorNode.inputs={nodemgr.ioElem.digital}
    avSeparatorNode.outputs={nodemgr.ioElem.digital,nodemgr.ioElem.digital}
    avSeparatorNode.color={1,0.34,0.07,0.2}
    addNode(avSeparatorNode)
end
