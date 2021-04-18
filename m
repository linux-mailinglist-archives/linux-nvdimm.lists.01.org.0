Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD9D36332F
	for <lists+linux-nvdimm@lfdr.de>; Sun, 18 Apr 2021 04:16:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5203E100EC1EB;
	Sat, 17 Apr 2021 19:16:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.121.120.192; helo=slot0.anpg-group.com; envelope-from=office@anpg-group.com; receiver=<UNKNOWN> 
Received: from slot0.anpg-group.com (slot0.anpg-group.com [185.121.120.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 493BB100EC1E3
	for <linux-nvdimm@lists.01.org>; Sat, 17 Apr 2021 19:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=anpg-group.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=office@anpg-group.com;
 bh=/wGnlMwyK1o1iQwa7OdZ9lF1430=;
 b=YpWro2soDIAdgztqHhPmD7X2qplMlmYr6wPQMXoVGGV8e3Gw2IcGYaimwRgeVXvhqCP9Jo9B65z4
   WEUpgqI5E/MrdZlkdAokH9+z3emkqWWDW+Ugs6kaNNRYEyQ5AKJZkR+5janZGN/o4XIF8wQ295ai
   vmmH6Sx/TFu6XTqObIYeSelu3gtzgxh6j+NIJsmMTI40+KIgXYr4RHFxgtHdZDMJX6l87YGVzQij
   PtX8YN294n7F3NLmM8Cu/sTH3h0/fVZTA5Oc8ETsR3oGmNGV/tzysiw3U/fhlp0PPd/SNBubn1nV
   6EDH4vx1CB/7ftJERYW2x/CRlSHfusB9G7QFAA==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=anpg-group.com;
 b=HPBx2N6wZ9pm/E355c8/U9V9DLWPUiSez+sibs2N+gaQD2F1gp5Atjvx+oGwkwFRdcIuKSBOQEGP
   rC4muTGC3ngicmI8c4FtDjDe1V4n7CW0z3UU5dQWqfFdB/XOeCVwKZGX7i8wHxkm1GehdfFjeD2x
   s/Mfz3+KSROOPioRBWPAsknuFH3X7eHFqr/ax/DVBrY189j+8rudI4jlZH4bQHWgpcRkuNLVF6mw
   x4ADAEpVg0O9Mt6V3S6XrvLdlakdUOw9/rOo1uxIz8DSQaAhIRQTQU8pjK1LR68K2rSTohS9CU4L
   eahs0M4OPveTgEGUp7AFA9rGyVbD0n5mMfkhcg==;
From: DE  ANPG Group <office@anpg-group.com>
To: linux-nvdimm@lists.01.org
Subject: Re: Business Proposal
Date: 18 Apr 2021 04:16:38 +0200
Message-ID: <20210418041638.81B818D4D1FA6538@anpg-group.com>
MIME-Version: 1.0
Message-ID-Hash: X3JDA7KITHK7CRRYAWXKKLDPF53NCWVS
X-Message-ID-Hash: X3JDA7KITHK7CRRYAWXKKLDPF53NCWVS
X-MailFrom: office@anpg-group.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: DE ANPG Group <josias.meloze1@gmail.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X3JDA7KITHK7CRRYAWXKKLDPF53NCWVS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============6315609274358338838=="

--===============6315609274358338838==
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">

<HTML><HEAD>
<META name=3DGENERATOR content=3D"MSHTML 11.00.10570.1001"></HEAD>
<BODY style=3D"MARGIN: 0.5em">
<P>Greetings linux-nvdimm@lists.01.org,<BR><BR></P>
<P style=3D"FONT-SIZE: small; FONT-FAMILY: Arial, Helvetica, sans-serif; WH=
ITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 40=
0; COLOR: rgb(34,34,34); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTER-=
SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font=
-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-=
width: 0px; text-decoration-thickness: initial; text-decoration-style: init=
ial; text-decoration-color: initial">How are you?<U>
 </U><U></U></P>
<P style=3D"FONT-SIZE: small; FONT-FAMILY: Arial, Helvetica, sans-serif; WH=
ITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 40=
0; COLOR: rgb(34,34,34); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTER-=
SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font=
-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-=
width: 0px; text-decoration-thickness: initial; text-decoration-style: init=
ial; text-decoration-color: initial">
My name is Josias Melo. I am a Procurement Officer with the Angolan Nationa=
l Petroleum and Gas Agency (ANPG). I am writing to extend a business reques=
t for you to stand as an agent or middle-man in a crude oil supply contract=
=2E<U></U><U></U></P>
<P style=3D"FONT-SIZE: small; FONT-FAMILY: Arial, Helvetica, sans-serif; WH=
ITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 40=
0; COLOR: rgb(34,34,34); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTER-=
SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font=
-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-=
width: 0px; text-decoration-thickness: initial; text-decoration-style: init=
ial; text-decoration-color: initial">
I am assuring you that good profits will be earned from the commission that=
 will be paid to middle-persons. I will provide exclusive details to you up=
on your acceptance.<BR><U></U><U><BR></U></P>
<P style=3D"FONT-SIZE: small; FONT-FAMILY: Arial, Helvetica, sans-serif; WH=
ITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: 40=
0; COLOR: rgb(34,34,34); FONT-STYLE: normal; ORPHANS: 2; WIDOWS: 2; LETTER-=
SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); TEXT-INDENT: 0px; font=
-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-stroke-=
width: 0px; text-decoration-thickness: initial; text-decoration-style: init=
ial; text-decoration-color: initial">Sincerely<BR>
Josias Melo<BR>Procurement Officer<BR><BR></P></BODY></HTML>
--===============6315609274358338838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============6315609274358338838==--
