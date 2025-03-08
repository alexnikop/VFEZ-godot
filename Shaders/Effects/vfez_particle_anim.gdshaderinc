group_uniforms particle.particle_anim;
uniform int particles_anim_h_frames : hint_range(1, 128) = 1;
uniform int particles_anim_v_frames : hint_range(1, 128) = 1;
uniform bool particles_anim_loop;
group_uniforms;

vec2 particle_anim(float instance_custom_z, vec2 uv)
{
    float h_frames = float(particles_anim_h_frames);
    float v_frames = float(particles_anim_v_frames);
    float particle_total_frames = float(particles_anim_h_frames * particles_anim_v_frames);
    float particle_frame = floor(instance_custom_z * float(particle_total_frames));
    if (!particles_anim_loop) {
        particle_frame = clamp(particle_frame, 0.0, particle_total_frames - 1.0);
    } else {
        particle_frame = mod(particle_frame, particle_total_frames);
    }
    uv /= vec2(h_frames, v_frames);
    uv += vec2(mod(particle_frame, h_frames) / h_frames, floor((particle_frame + 0.5) / h_frames) / v_frames);
    return uv;
}