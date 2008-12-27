class ReportsController < ApplicationController
  
  PROCESS_REGEX = Regexp.compile( '^Process:\s*(\w+)', Regexp::MULTILINE )
  BUNDLE_REGEX = Regexp.compile( 'Identifier:\s*([^\r\n]+)', Regexp::MULTILINE )
  VERSION_REGEX = Regexp.compile( 'Version:\s*([^\r\n]+)', Regexp::MULTILINE )
  CODE_REGEX = Regexp.compile( 'Code Type:\s*([^\r\n]+)', Regexp::MULTILINE )
  PATH_REGEX = Regexp.compile( 'Path:\s*([^\r\n]+)', Regexp::MULTILINE )
  OSVER_REGEX = Regexp.compile( 'OS Version:\s*([^\r\n]+)', Regexp::MULTILINE )
  EXTYPE_REGEX = Regexp.compile( 'Exception Type:\s*([^\r\n]+)', Regexp::MULTILINE )
  EXCODE_REGEX = Regexp.compile( 'Exception Codes:\s*([^\r\n]+)', Regexp::MULTILINE )
  
  def index
    @reports = Report.find( :all )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reports }
    end
  end

  def show
    @report = Report.find( params[:id] )

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @report }
    end
  end

  def new
    @report = Report.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @report }
    end
  end

  def edit
    @report = Report.find( params[:id] )
  end

  def create
    report = params[:report][:report]
    
    match = PROCESS_REGEX.match( report )
    raise unless match
    process = match[1].chomp
    
    match = BUNDLE_REGEX.match( report )
    raise unless match
    bundle = match[1].chomp
    
    app = App.find_or_create_by_process_and_bundle( process, bundle )
    raise unless app
    
    match = VERSION_REGEX.match( report )
    raise unless match
    version = match[1].chomp

    match = CODE_REGEX.match( report )
    raise unless match
    code = match[1].chomp

    match = PATH_REGEX.match( report )
    raise unless match
    path = match[1].chomp

    match = OSVER_REGEX.match( report )
    raise unless match
    osver = match[1].chomp

    match = EXTYPE_REGEX.match( report )
    raise unless match
    extype = match[1].chomp

    match = EXCODE_REGEX.match( report )
    raise unless match
    excode = match[1].chomp

    crash = app.crashes.create(
                          :version => version,
                          :code => code,
                          :path => path,
                          :osver => osver,
                          :extype => extype,
                          :excode => excode
                          )
    raise unless crash
    
    @report = crash.build_report( params[:report] )

    respond_to do |format|
      if @report.save
        flash[:notice] = 'Report was successfully created.'
        format.html { redirect_to( @report ) }
        format.xml  { render :xml => @report, :status => :created, :location => @report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @report = Report.find( params[:id] )

    respond_to do |format|
      if @report.update_attributes( params[:report] )
        flash[:notice] = 'Report was successfully updated.'
        format.html { redirect_to( @report ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @report = Report.find( params[:id] )
    @report.destroy

    respond_to do |format|
      format.html { redirect_to( admin_reports_url ) }
      format.xml  { head :ok }
    end
  end
  
end
