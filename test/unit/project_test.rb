require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "a random salt should be 8 characters" do
    assert_equal 8, Project.random_salt.size
  end
  
  test "a project should get created and set the password" do
    p = Project.new(:name => "Test", :password => "glock", :terms => "a")
    
    assert p.valid?
    assert p.save
    assert_not_equal "glock", p.password
    assert_equal p, Project.authenticate("Test", "glock")
  end
  
  test "a project should be authenticatable" do
    assert_equal projects(:kastner_town),
      Project.authenticate("Kastner Town", "password")
  end

  test "a project should be authenticatable (case insensitive)" do
    assert_equal projects(:kastner_town),
      Project.authenticate("kasTner town", "password")
  end
  
  test "a non-existant project should return nil" do
    assert_equal nil, Project.authenticate("Bob", "larry")
  end
  
  test "a project should have a unique name (case insensitive)" do
    p = Project.new(:name => "Kastner tOwn", :password => "a", :terms => "a")
    
    assert !p.valid?
    assert p.errors.on(:name)
  end
  
  test "a cookie should be stable" do
    assert_equal projects(:kastner_town).cookie, projects(:kastner_town).cookie
  end
  
  test "a project name can't have __|__ in it" do
    p = Project.new(:name => "bad__|__times", :password => "xx", :terms => "a")
    assert !p.valid?
    assert p.errors.on(:name)
  end
  
  test "a project should be finable by it's cookie" do
    assert_equal projects(:kastner_town), Project.get_from_cookie("Kastner Town__|__d98439858778de0bfb823d4e6b89c16f5aeb8618__|__779d3bb77442ae1b85d9f2a4d662d69fd670d4c3")
  end
  
  test "a cookie with tamppered pass part should fail" do
    assert_equal nil, Project.get_from_cookie("Kastner Town__|__d98439858778de0bfb823d4e6b89c16f5aeb8618__|__bob")
  end

  test "a cookie with tamppered name part should fail" do
    assert_equal nil, Project.get_from_cookie("Kastner Town__|__bob__|__779d3bb77442ae1b85d9f2a4d662d69fd670d4c3")
  end
  
  test "a project that changes its password should have an invalid cookie" do
    projects(:kastner_town).change_password("bob")
    assert_equal nil, Project.get_from_cookie("Kastner Town__|__d98439858778de0bfb823d4e6b89c16f5aeb8618__|__779d3bb77442ae1b85d9f2a4d662d69fd670d4c3")
  end

  test "a project that changes its password should auth with new pass" do
    projects(:kastner_town).change_password("bob")
    assert_equal projects(:kastner_town),
      Project.authenticate("kasTner town", "bob")
  end
end
