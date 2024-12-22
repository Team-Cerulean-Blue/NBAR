return function(nodemgr,addNode)
    local monoNTSCNoiseNode = table.shallow_copy(nodemgr.nodeClass)
    monoNTSCNoiseNode.title="NTSC monochrome noise"
    monoNTSCNoiseNode.shortTitle="NTSC monochrome noise"
    monoNTSCNoiseNode.id="ntsc-mchrome-noise"
    monoNTSCNoiseNode.about="Node that adds monochrome noise to the NTSC video."
    monoNTSCNoiseNode.inputs={nodemgr.ioElem.avideo}
    monoNTSCNoiseNode.outputs={nodemgr.ioElem.avideo}
    monoNTSCNoiseNode.color={0.6,0.58,0.58,0.2}
    addNode(monoNTSCNoiseNode)
end
