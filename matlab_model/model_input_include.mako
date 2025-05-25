
% for input in inputs:
    % if input == "vx_m_s":
    in_data.vx_m_s = in.current_body_vel_ms.x;
    % elif input == "wz_rad_s":
    in_data.wz_rad_s = in.current_angular_rate_rads.z;
    % elif input == "delta_deg":
    in_data.delta_deg = in.steering_angle_deg;
    % elif input == "accel":
    in_data.accel = in.input.requested_accel;
    % elif input == "brake":
    in_data.brake = in.input.requested_brake;
    % endif
% endfor

% for estim_output in estim_outputs:
    in_data.${estim_output} = estimator_outputs.${estim_output};
% endfor