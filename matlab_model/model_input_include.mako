
% for input in inputs:
    % if input == "vx_raw_m_s":
    in_data.vx_raw_m_s = in.current_body_vel_ms.x;
    % elif input == "vy_raw_m_s":
    in_data.vy_raw_m_s = in.current_body_vel_ms.y;
    % elif input == "wz_rad_s":
    in_data.wz_rad_s = in.current_angular_rate_rads.z;
    % elif input == "steer_sensor_raw":
    in_data.steer_sensor_raw = in.steering_angle_deg;
    % elif input == "accel":
    in_data.accel = in.input.requested_accel;
    % elif input == "brake":
    in_data.brake = in.input.requested_brake;
    % elif input == "loadcell_fl":
    in_data.loadcell_fl = in.loadcells.FL;
    % elif input == "loadcell_fr":
    in_data.loadcell_fr = in.loadcells.FR;
    % elif input == "loadcell_rl":
    in_data.loadcell_rl = in.loadcells.RL;
    % elif input == "loadcell_rr":
    in_data.loadcell_rr = in.loadcells.RR;
    % elif input == "ax_m_s2":
    in_data.ax_m_s2 = in.current_body_accel_mss.x;
    % elif input == "ay_m_s2":
    in_data.ay_m_s2 = in.current_body_accel_mss.y;
    % elif input == "torq_Nm_fl":
    in_data.torq_Nm_fl = in.current_torques_nm.FL;
    % elif input == "torq_Nm_fr":
    in_data.torq_Nm_fr = in.current_torques_nm.FR;
    % elif input == "torq_Nm_rl":
    in_data.torq_Nm_rl = in.current_torques_nm.RL;
    % elif input == "torq_Nm_rr":
    in_data.torq_Nm_rr = in.current_torques_nm.RR;
    % elif input == "motor_rpm_fl":
    in_data.motor_rpm_fl = in.current_rpms.FL;
    % elif input == "motor_rpm_fr":
    in_data.motor_rpm_fr = in.current_rpms.FR;
    % elif input == "motor_rpm_rl":
    in_data.motor_rpm_rl = in.current_rpms.RL;
    % elif input == "motor_rpm_rr":
    in_data.motor_rpm_rr = in.current_rpms.RR;
    % elif input == "ins_mode":
    in_data.ins_mode = in.ins_status.status_mode;
    % elif input == "ins_vel_u":
    in_data.ins_vel_u = in.ins_status.vel_uncertainty;
    % endif
% endfor

% for estim_output in estim_outputs:
    in_data.${estim_output} = estimator_outputs.${estim_output};
% endfor