vec2 _001(vec2 uv, float x, float y)
{
	mat2 scale = mat2(
				vec2(x, 0.0), 
				vec2(0.0, y)
				);	
	uv -= 0.5;
	uv = uv * scale;
	uv += 0.5;
	return uv;
}
float circle(vec2 uv, float diameter, float feather)
{
	float radius = diameter/2.0;
	return smoothstep(radius, radius + feather, length(uv - vec2(0.5)));
}
float donut (vec2 uv,float size, float thickness,float feather){
	float c_in = circle(uv,size - thickness,feather); 
	float c_out = circle(uv,size, feather); 
	return (1.0 - c_out) - (1.0 - c_in); 
}
float rectangle (vec2 uv, float width, float height){
	vec2 uv_cartesian = uv * 2.0 - 1.0; 
	vec2 uv_reflected = abs(uv_cartesian); 
	float dfx = step(width,uv_reflected.x);
	float dfy = step(height, uv_reflected.y); 
	return max(dfx,dfy); 
}
float rectanglef (vec2 uv, float width, float height, float feather){
	vec2 uv_cartesian = uv * 2.0 - 1.0; 
	vec2 uv_reflected = abs(uv_cartesian); 
	float dfx = smoothstep(width,width+feather,uv_reflected.x);
	float dfy = smoothstep(height,height+feather,uv_reflected.y); 
	return max(dfx,dfy); 
}

float polygon(vec2 uv, float width, int sides)
{
	uv = uv * 2.0 - 1.0;
	float angle = atan(uv.x, uv.y);
	float radius = TAU / float(sides);	
	float dist = cos(floor(0.5 + angle / radius) * radius - angle)* length(uv) ;
	float poly = step(width, dist);
	return poly; 
}
float star(vec2 uv, float diameter,int sides, float bloat, float rounded)
{
	uv -= 0.5; 
	uv.y += 0.05;
   	float r = diameter/2.0; 
    float an = PI/float(sides);
    float en = PI/mix(float(sides),2.0,bloat);  // m is between 2 and n
    vec2  acs = vec2(cos(an),sin(an));
    vec2  ecs = vec2(cos(en),sin(en)); // ecs=vec2(0,1) for regular polygon

    float bn = mod(atan(uv.x,uv.y),2.0*an) - an;
    uv = length(uv)*vec2(cos(bn),abs(sin(bn)));
    uv -= r*acs;
    uv += ecs*clamp( -dot(uv,ecs), 0.0, r*acs.y/ecs.y);
    return step(rounded/10.0,length(uv)*sign(uv.x));
}
float dot2( in vec2 v ) { return dot(v,v); }
float heart2(vec2 p, float size )
{
	float s = 1.0/size/0.8; 
	p = _001(p,s,s); 
	p.y += 0.05; 
	p.x -= 0.5; 
    p.x = abs(p.x);
	
	float h; 
    if( p.y+p.x>1.0 )
        h = sqrt(dot2(p-vec2(0.25,0.75))) - sqrt(2.0)/4.0;
	else	
    	h = sqrt(min(dot2(p-vec2(0.00,1.00)),
            dot2(p-0.5*max(p.x+p.y,0.0)))) * sign(p.x-p.y);
	return step(0.0,h); 
}