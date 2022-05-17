class SimpleTree
  attr_reader :root, :nodes

  def initialize(root, descendants)
    @root = root
    @descendants = descendants

    @nodes = {}
    ([@root] + @descendants).each do |d|
      d.child_nodes = []
      @nodes[d.id] = d
    end

    @descendants.each { |d| @nodes[d.parent_id].child_nodes << @nodes[d.id] }
  end
end
