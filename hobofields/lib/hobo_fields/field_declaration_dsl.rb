module HoboFields

  class FieldDeclarationDsl < BlankSlate

    def initialize(model)
      @model = model
    end

    attr_reader :model


    def timestamps
      field(:created_at, :datetime)
      field(:updated_at, :datetime)
    end
    
    def userstamps
      @model.belongs_to :created_by, :foreign_key => :created_by, :class_name => "User"
      @model.belongs_to :updated_by, :foreign_key => :updated_by, :class_name => "User"
      @model.add_callbacks_for_userstamps
    end
    
    def usertimestamps
      timestamps
      userstamps
    end

    def field(name, type, *args)
      @model.declare_field(name, type, *args)
    end


    def method_missing(name, *args)
      field(name, *args)
    end

  end

end
