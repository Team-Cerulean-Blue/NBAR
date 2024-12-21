return function(nodemgr)
    local videoInputNode = table.shallow_copy(nodemgr.nodeClass)
    videoInputNode.title="Digital video input The FitnessGram Pacer Test is a multistage aerobic capacity test that progressively gets more difficult as it continues"
    videoInputNode.id="digital-video-input"
    videoInputNode.about="Node that returns a digital video file inputted by the user."
    videoInputNode.outputs={nodemgr.ioElem.digital}
    nodemgr.addNodeToScreen(videoInputNode)
end