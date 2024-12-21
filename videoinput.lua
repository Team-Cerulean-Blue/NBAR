return function(nodemgr)
    local videoInputNode = table.shallow_copy(nodemgr.nodeClass)
    videoInputNode.title="Digital video input"
    videoInputNode.shortTitle="Digital video input"
    videoInputNode.id="digital-video-input"
    videoInputNode.about="Node that returns a digital video file inputted by the user."
    videoInputNode.outputs={nodemgr.ioElem.digital}
    videoInputNode.color={0.49019607843137253,0.8549019607843137,0.34509803921568627,0.2}
    return videoInputNode
end
