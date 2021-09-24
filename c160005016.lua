--灰覇炎神ヴァスト・ヴァルカン［Ｒ］
function c160005016.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(160005016,0))
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c160005016.cost)
	e1:SetCondition(c160005016.efcon)
	e1:SetTarget(c160005016.target)
	e1:SetOperation(c160005016.activate)
	c:RegisterEffect(e1)
end
function c160005016.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,1) end
	Duel.DiscardDeck(tp,1,REASON_COST)
end
function c160005016.efcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(0x74d000000)
end
function c160005016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c160005016.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c160005016.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,g,1,0,0)
end
function c160005016.filter(c)
	return c:IsFaceup() and c:GetAttack()>0 and not (c:IsSummonType(0x74d000000) and c:IsSetCard(0x7666))
end
function c160005016.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c160005016.filter,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if #g>0 then
		Duel.HintSelection(g)
		local lv=tc:GetLevel()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(lv*-100)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		Duel.BreakEffect()
		Duel.Damage(1-tp,lv*100,REASON_EFFECT)
	end
end