require 'test/unit'
require 'test_helper'

class SimpleTheme < Scruffy::Themes::Base
  def initialize
    super({
        :background => [:white, :white],
        :marker => :black,
        :colors => %w(blue green red orange yellow purple pink),
        :stroke_color => 'white'
      })
  end
end

$make_png = true
begin
  require 'RMagick'
rescue LoadError
  $make_png = nil
end

class GraphCreationTest < Test::Unit::TestCase
  BASE_DIR = File.dirname(__FILE__)
  WEBSITE_DIR = BASE_DIR + "/../website/images/graphs"

  def test_create_pie
    graph = Scruffy::Graph.new
    graph.title = "Favourite Snacks"
    graph.renderer = Scruffy::Renderers::Pie.new

    graph.add :pie, '', {
      'Apple' => 20,
      'Banana' => 100,
      'Orange' => 70,
      'Taco' => 30
    }

    graph.render :to => "#{WEBSITE_DIR}/pie_test.svg"
    graph.render :width => 400, :to => "#{WEBSITE_DIR}/pie_test.png", :as => 'png' if $make_png
  end
  
  def test_create_line
    graph = Scruffy::Graph.new
    graph.title = "Sample Line Graph"
    graph.renderer = Scruffy::Renderers::Standard.new

    graph.add :line, 'Example', [20, 100, 70, 30, 106]

    graph.render :to => "#{WEBSITE_DIR}/line_test.svg"
    graph.render  :width => 400, :to => "#{WEBSITE_DIR}/line_test.png", :as => 'png' if $make_png
  end
  
  
  def test_create_line_with_negatives
    graph = Scruffy::Graph.new
    graph.title = "Sample Line Graph"
    graph.renderer = Scruffy::Renderers::Standard.new

    graph.add :line, 'Example', [-20, 100, -70, -30, 106]
    theme = Scruffy::Themes::Base.new :background=>"#ffffff", :marker=>"#444444",
                          :colors=>["#4f83bf","#be514e","#a1ba5e","#82649a"],
                          :title_font_size => 30, :marker_font_size=>10
    graph.render :to => "#{WEBSITE_DIR}/line_test_with_negatives.svg",:theme=>theme
    graph.render  :width => 400, :to => "#{WEBSITE_DIR}/line_test_with_negatives.png",:theme=>theme, :as => 'png' if $make_png
  end
  
  
  def test_create_negative_line
    graph = Scruffy::Graph.new
    graph.title = "Sample Line Graph"
    graph.renderer = Scruffy::Renderers::Standard.new

    graph.add :line, 'Example', [-20, -100, -70, -30, -106]
    theme = Scruffy::Themes::Apples.new 
    graph.render :to => "#{WEBSITE_DIR}/negative_line_test.svg",:theme=>theme
    graph.render  :width => 600,:theme=>theme, :to => "#{WEBSITE_DIR}/negative_line_test.png", :as => 'png' if $make_png
  end
  
  def test_create_small_value_line
    graph = Scruffy::Graph.new
    graph.title = "Sample Line Graph"
    graph.renderer = Scruffy::Renderers::Standard.new
    graph.value_formatter = Scruffy::Formatters::Number.new(:precision => 1)
    graph.add :line, 'Example', [0.2,0.5,0.1,0.9,0.8,1.2,0.05,1]

    graph.render :to => "#{WEBSITE_DIR}/small_value_line_test.svg"
    graph.render  :width => 400, :to => "#{WEBSITE_DIR}/small_value_line_test.png", :as => 'png' if $make_png
  end

  
  def test_create_bar
    graph = Scruffy::Graph.new
    graph.title = "Sample Bar Graph"
    graph.renderer = Scruffy::Renderers::Standard.new
    graph.add :bar, 'Example', [20, 100, 70, 30, 106]
    graph.render :to => "#{WEBSITE_DIR}/bar_test.svg"
    graph.render  :width => 400, :to => "#{WEBSITE_DIR}/bar_test.png", :as => 'png' if $make_png
  end
  
  
  
  
  def test_create_bar_with_negatives
    graph = Scruffy::Graph.new
    graph.title = "Sample Bar Graph"
    graph.renderer = Scruffy::Renderers::Standard.new
    graph.add :bar, 'Example', [20, 100,-10, 70, 30, -40, 106]
    graph.render :to => "#{WEBSITE_DIR}/negative_bar_test.svg"
    graph.render  :width => 400, :to => "#{WEBSITE_DIR}/negative_bar_test.png", :as => 'png' if $make_png
  end
  
  
  def test_create_bar_with_all_negatives
    graph = Scruffy::Graph.new
    graph.title = "Sample Bar Graph"
    graph.renderer = Scruffy::Renderers::Standard.new
    graph.add :bar, 'Example', [-20, -100,-10, -70, -30, -40, -106]
    graph.render :to => "#{WEBSITE_DIR}/all_negative_bar_test.svg"
    graph.render  :width => 400, :to => "#{WEBSITE_DIR}/all_negative_bar_test.png", :as => 'png' if $make_png
  end
  
  
  def test_split
    graph = Scruffy::Graph.new
    graph.title = "Long-term Comparisons"
    graph.value_formatter = Scruffy::Formatters::Currency.new(:special_negatives => true, :negative_color => '#ff7777')
    graph.renderer = Scruffy::Renderers::Split.new(:split_label => 'Northeastern (Top) / Central (Bottom)')

    graph.add :area, 'Jeff', [20, -5, 100, 70, 30, 106, 203, 100, 50, 203, 289, 20], :category => :top    
    graph.add :area, 'Jerry', [-10, 70, 20, 102, 201, 26, 30, 106, 203, 100, 50, 39], :category => :top
    graph.add :bar,  'Jack', [30, 0, 49, 29, 100, 203, 70, 20, 102, 201, 26, 130], :category => :bottom
    graph.add :line, 'Brasten', [42, 10, 75, 150, 130, 70, -10, -20, 50, 92, -21, 19], :categories => [:top, :bottom]
    graph.add :line, 'Jim', [-10, -20, 50, 92, -21, 56, 92, 84, 82, 100, 39, 120], :categories => [:top, :bottom]
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    
    graph.render :to => "#{WEBSITE_DIR}/split_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/split_test.png", :as => 'png' if $make_png
  end
  
  def test_stacking
    graph = Scruffy::Graph.new
    graph.title = "Comparative Agent Performance"
    graph.value_formatter = Scruffy::Formatters::Percentage.new(:precision => 0)
    graph.add :stacked do |stacked|
      stacked.add :bar, 'Jack', [30, 60, 49, 29, 100, 120]
      stacked.add :bar, 'Jill', [120, 240, 0, 100, 140, 20]
      stacked.add :bar, 'Hill', [10, 10, 90, 20, 40, 10]
    end
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
    graph.render :to => "#{WEBSITE_DIR}/stacking_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/stacking_test.png", :as => 'png' if $make_png
  end
  
  
  def test_reg_multi_bar
    graph = Scruffy::Graph.new
    graph.title = "Comparative Agent Performance"
    graph.value_formatter = Scruffy::Formatters::Percentage.new(:precision => 0)
    #graph.add :multi do |multi|
      graph.add :bar, 'Jack', [30, 60, 49, 29, 100, 120]
      graph.add :bar, 'Jill', [120, 240, 0, 100, 140, 20]
      graph.add :bar, 'Hill', [10, 10, 90, 20, 40, 10]
    #end
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
    graph.render :to => "#{WEBSITE_DIR}/reg_multi_bar_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/reg_multi_bar_test.png", :as => 'png' if $make_png
  end
  
  def test_multi_bar
    graph = Scruffy::Graph.new
    graph.title = "Comparative Agent Performance"
    graph.value_formatter = Scruffy::Formatters::Percentage.new(:precision => 0)
    graph.add :multi do |multi|
      multi.add :multi_bar, 'Jack', [30, 60, 49, 29, 100, 120]
      multi.add :multi_bar, 'Jill', [120, 240, 0, 100, 140, 20]
      multi.add :multi_bar, 'Hill', [10, 10, 90, 20, 40, 10]
      multi.add :multi_bar, 'Bob', [-10, -20, -30, -40, -50, -60]
    end
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
    graph.render :to => "#{WEBSITE_DIR}/multi_bar_test.svg"
    graph.point_markers_ticks = true
    graph.render  :width => 900, :to => "#{WEBSITE_DIR}/multi_bar_test.png", :as => 'png' if $make_png
  end
  
  
  def test_box_plot
    graph = Scruffy::Graph.new()
    graph.title = "Box Plot Test"
    graph.value_formatter = Scruffy::Formatters::Percentage.new(:precision => 0)
    graph.add :box, "Test Data", [
                                [10,8,6.2,4,2],
                                [12,9,8.2,4.2,3.5],
                                [10,8,5.3,4,2],
                                [12,9,8.2,4.2,3.5],
                                [10,8,6.6,4,2],
                                [12,9,8.2,4.2,3.5]
                                ]
                                
    graph.point_markers = ['Jan', 'Feb','Jan', 'Feb','Jan', 'Feb']
    graph.point_markers_ticks = true
    theme = Scruffy::Themes::Base.new :background=>"#ffffff", :marker=>"#aaaaaa",
                          :colors=>["#4f83bf","#be514e","#a1ba5e","#82649a"],
                          :outlines=>["#be514e","#a1ba5e","#82649a","#4f83bf"]
    graph.render :to => "#{WEBSITE_DIR}/box_plot_test.svg",:padding=>:padded,:theme=>theme
    graph.render  :size => [600,540],:theme=>theme, :to => "#{WEBSITE_DIR}/box_plot_test.png", :as => 'png',:padding=>:padded if $make_png
  end
  
 
  
  def test_rotated_point_markers
    graph = Scruffy::Graph.new({:point_markers_rotation=>30}) #
    graph.title = "Comparative Agent Performance"
    graph.value_formatter = Scruffy::Formatters::Percentage.new(:precision => 0)
    graph.add :stacked do |stacked|
      stacked.add :bar, 'Jack', [30, 60, 49, 29, 100, 120]
      stacked.add :bar, 'Jill', [120, 240, 0, 100, 140, 20]
      stacked.add :bar, 'Hill', [10, 10, 90, 20, 40, 10]
    end
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
    graph.point_markers_ticks = true
    #Rotation was set when the graph was created
    #You can also do something like this
    #graph.point_markers_rotation = 90
    graph.render :to => "#{WEBSITE_DIR}/rotated_point_markers_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/rotated_point_markers_test.png", :as => 'png' if $make_png
  end
  
  
  def test_multi_layered
    graph = Scruffy::Graph.new
    graph.title = "Some Kind of Information"
    graph.renderer = Scruffy::Renderers::Cubed.new

    graph.add :area, 'Jeff', [20, -5, 100, 70, 30, 106], :categories => [:top_left, :bottom_right]    
    graph.add :area, 'Jerry', [-10, 70, 20, 102, 201, 26], :categories => [:bottom_left, :buttom_right]
    graph.add :bar,  'Jack', [30, 0, 49, 29, 100, 203], :categories => [:bottom_left, :top_right]
    graph.add :line, 'Brasten', [42, 10, 75, 150, 130, 70], :categories => [:top_right, :bottom_left]
    graph.add :line, 'Jim', [-10, -20, 50, 92, -21, 56], :categories => [:top_left, :bottom_right]
    graph.point_markers = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun']
    graph.render :to => "#{WEBSITE_DIR}/multi_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/multi_test.png", :as => 'png' if $make_png
  end
  
  def test_scatter
    graph = Scruffy::Graph.new
    graph.title = "Some Kind of Information"
    graph.renderer = Scruffy::Renderers::Standard.new

    graph.add :scatter, 'Stephanie', {0 => 0, 1 => 1, 2 => 4, 3 => 9, 4 => 8, 5 => 10, 6 => 12, 7 => 3, 8 => 13}    
    graph.add :line, 'Artiom', {-3 => 2, 1.5 => 6, 2 => 4.5, 15 => -4}, :dots => true   
    graph.add :scatter, 'Sam', [[-3,15], [1.5,18], [2,9], [15,6]]   
    graph.render :to => "#{WEBSITE_DIR}/scatter_test.svg"
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/scatter_test.png", :as => 'png' if $make_png
  end
  
  def test_scatter_by_date
    graph = Scruffy::Graph.new
    graph.title = "Some Kind of Information"
    graph.renderer = Scruffy::Renderers::Standard.new
    graph.key_formatter = Scruffy::Formatters::Date.new("%H:%M")
    h = {}
    start = Time.local(2009, 1, 20, 12, 0, 0)
    30.times{|i| h[start + 60*i] = i*i}
    
    graph.add :scatter, 'DNI', h
    graph.render :to => "#{WEBSITE_DIR}/scatter_date_test.svg", :calculate_markers => true
    graph.render  :width => 500, :to => "#{WEBSITE_DIR}/scatter_date_test.png", :as => 'png' if $make_png
  end
end
