class User < Struct.new(:username, :pub)
    def initialize(un, pub)
        self.username = un
        self.pub = pub
    end
    def inspect
        self.values
    end
end
