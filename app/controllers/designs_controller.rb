class DesignsController < ApplicationController

  def index
    @stuffType = StuffType.where(:active => true).order('priority ASC')
    @stuffSize = StuffSize.where(:active => true).order('priority DESC')
  end

  def how_to

  end

  def existed
    @existed = []
    StuffExist.where({:active => true}).all.each do |stuff_exist|
      stuffExistSize = StuffExistSize.where({stuff_exist:stuff_exist})
      if !stuffExistSize.nil?
        size = []
        stuffExistSize.each do |stuff_exist_size|
          size.push({'name':stuff_exist_size.name,
              'sex':stuff_exist_size.sex,
              'price':stuff_exist_size.price,
              'priority':stuff_exist_size.priority })
        end
        if size.length != 0
          @existed.push({'id':stuff_exist.id,
          'name':stuff_exist.name,
          'size':size,
          'desc':stuff_exist.desc,
          'stuff_exist_img':stuff_exist.stuff_exist_img.url()
          })
        end
      end
    end
    @existed
  end
end
