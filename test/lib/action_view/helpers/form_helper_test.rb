require 'test_helper'

class FormHelperTest < ActionView::TestCase
  def test_bootstrap_controlgroup_wrap
    object  = mock
    errors  = { :name   => [] }
    options = { :object => object }
    content = ::ActiveSupport::SafeBuffer.new('content')
    stub(object).errors { errors }
    stub(object).name   { 'Object Name' }

    expected_code = %{<div class="control-group"><label class=\"control-label\" for="post_name">Name</label><div class="controls">content</div></div>}
    assert_equal expected_code, bootstrap_controlgroup_wrap(:post, :name, content, options)
  end

  def test_bootstrap_controlgroup_wrap_with_label
    object  = mock
    errors  = { :name   => [] }
    options = { :object => object, :label => "Custom" }
    content = ::ActiveSupport::SafeBuffer.new('content')
    stub(object).errors { errors }
    stub(object).name   { 'Object Name' }

    expected_code = %{<div class="control-group"><label class=\"control-label\" for="post_name">Custom</label><div class="controls">content</div></div>}
    assert_equal expected_code, bootstrap_controlgroup_wrap(:post, :name, content, options)
  end

  def test_bootstrap_controlgroup_wrap_with_errors
    object  = mock
    errors  = { :name   => ["can't be blank"] }
    options = { :object => object }
    content = ::ActiveSupport::SafeBuffer.new('content')
    stub(object).errors { errors }
    stub(object).name   { 'Object Name' }

    expected_code = %{<div class="control-group error"><label class=\"control-label\" for="post_name">Name</label><div class="controls">content<span class="help-inline"> can't be blank</span></div></div>}
    assert_equal expected_code, bootstrap_controlgroup_wrap(:post, :name, content, options)
  end

  def test_bootstrap_controlgroup_wrap_with_many_errors
    object  = mock
    errors  = { :name   => ["has already been taken", "is reserved", "must be odd"] }
    options = { :object => object }
    content = ::ActiveSupport::SafeBuffer.new('content')
    stub(object).errors { errors }
    stub(object).name   { 'Object Name' }

    expected_code = %{<div class="control-group error"><label class=\"control-label\" for="post_name">Name</label><div class="controls">content<span class="help-inline"> has already been taken, is reserved, and must be odd</span></div></div>}
    assert_equal expected_code, bootstrap_controlgroup_wrap(:post, :name, content, options)
  end

  def test_bootstrap_controlgroup_wrap_with_hint
    object  = mock
    errors  = {}
    options = { :object => object, :hint => "format matters" }
    content = ::ActiveSupport::SafeBuffer.new('content')
    stub(object).errors { errors }
    stub(object).name   { 'Object Name' }

    expected_code = %{<div class="control-group"><label class=\"control-label\" for="post_name">Name</label><div class="controls">content<span class="help-inline"> format matters</span></div></div>}
    assert_equal expected_code, bootstrap_controlgroup_wrap(:post, :name, content, options)
  end

  def test_bootstrap_controlgroup_wrap_with_hint_and_errors
    object  = mock
    errors  = { :name   => ["can't be blank"] }
    options = { :object => object, :hint => "format matters" }
    content = ::ActiveSupport::SafeBuffer.new('content')
    stub(object).errors { errors }
    stub(object).name   { 'Object Name' }

    expected_code = %{<div class="control-group error"><label class=\"control-label\" for="post_name">Name</label><div class="controls">content<span class="help-inline"> can't be blank</span></div></div>}
    assert_equal expected_code, bootstrap_controlgroup_wrap(:post, :name, content, options)
  end

  def test_bootstrap_controlgroup_wrap_with_help_block
    object  = mock
    errors  = {}
    options = { :object => object, :help_block => "This is some text" }
    content = ::ActiveSupport::SafeBuffer.new('content')
    stub(object).errors { errors }
    stub(object).name   { 'Object Name' }

    expected_code = %{<div class="control-group"><label class=\"control-label\" for="post_name">Name</label><div class="controls">content</div><div class=\"controls help-block\">This is some text</div></div>}
    assert_equal expected_code, bootstrap_controlgroup_wrap(:post, :name, content, options)
  end

  def test_bootstrap_text_field
    html, text_field = mock, mock
    options = { :object => mock }

    mock(self).text_field(:post, :name, options) { text_field }
    mock(self).bootstrap_controlgroup_wrap(:post, :name, text_field, options.dup) { html }
    assert_equal html, bootstrap_text_field(:post, :name, options)
  end

  def test_bootstrap_email_field
    html, email_field = mock, mock
    options = { :object => mock }

    mock(self).email_field(:post, :email, options) { email_field }
    mock(self).bootstrap_controlgroup_wrap(:post, :email, email_field, options.dup) { html }
    assert_equal html, bootstrap_email_field(:post, :email, options)
  end

  def test_bootstrap_password_field
    html, password_field = mock, mock
    options = { :object => mock }

    mock(self).password_field(:post, :password, options) { password_field }
    mock(self).bootstrap_controlgroup_wrap(:post, :password, password_field, options.dup) { html }
    assert_equal html, bootstrap_password_field(:post, :password, options)
  end

  def test_bootstrap_collection_select
    html, collection_select_html, collection, object = mock, mock, mock, mock
    options = { :object => mock }

    mock(self).collection_select(:post, :name, collection, :id, :name, options, {}) { collection_select_html }
    mock(self).bootstrap_controlgroup_wrap(:post, :name, collection_select_html, options.dup) { html }

    assert_equal html, bootstrap_collection_select(:post, :name, collection, :id ,:name, options)
  end

  def test_bootstrap_select
    choices, select_html, html = mock, mock, mock
    options = { :object => mock }

    mock(self).select(:post, :name, choices, options, {}) { select_html }
    mock(self).bootstrap_controlgroup_wrap(:post, :name, select_html, options.dup) { html }

    assert_equal html, bootstrap_select(:post, :name, choices, options, {})
  end

  def test_bootstrap_file_field
    html, text_field = mock, mock
    options = { :object => mock }

    mock(self).file_field(:post, :attachment, options) { text_field }
    mock(self).bootstrap_controlgroup_wrap(:post, :attachment, text_field, options.dup) { html }
    assert_equal html, bootstrap_file_field(:post, :attachment, options)
  end

  def test_bootstrap_text_area
    html, text_area = mock, mock
    options = { :object => mock }

    mock(self).text_area(:post, :description, options) { text_area }
    mock(self).bootstrap_controlgroup_wrap(:post, :description, text_area, options.dup) { html }
    assert_equal html, bootstrap_text_area(:post, :description, options)
  end

  def test_bootstrap_check_box
    html, check_box = mock, mock
    options = { :object => mock }

    mock(self).check_box(:post, :description, options) { check_box }
    mock(self).bootstrap_controlgroup_wrap(:post, :description, check_box, options.dup) { html }
    assert_equal html, bootstrap_check_box(:post, :description, options)
  end

  def test_ignore_bootstrap_options
    html, text_area = mock, mock
    options = { :object => mock, :label => "Custom", :hint => "be careful" }

    mock(self).text_area(:post, :description, options.except(:label, :hint)) { text_area }
    mock(self).bootstrap_controlgroup_wrap(:post, :description, text_area, options.dup) { html }
    assert_equal html, bootstrap_text_area(:post, :description, options)
  end


end
