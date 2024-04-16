module DetermineExecEnv
  module_function
  def _m1silicon_in_container?
    %x(cat /proc/self/cgroup) =~ /^0::/
  end

  def _m1silicon_no_container?
    %x(cat /proc/self/cgroup) =~ /No such file or directory/
  end

  def _amd_in_container?
    _amd? == 1
  end

  def _amd_no_container?
    !_m1silicon_no_container? && _amd? == 0
  end

  def _amd?
    %x(echo `[ ! -f /.dockerenv ]` $?).to_i
  end

  def in_container?
    _amd_in_container? || _m1silicon_in_container?
  end
end