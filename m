Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC729D0493
	for <lists+linux-nvdimm@lfdr.de>; Wed,  9 Oct 2019 02:06:13 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 598A810FC5458;
	Tue,  8 Oct 2019 17:08:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.6.134.124; helo=sonic315-14.consmr.mail.bf2.yahoo.com; envelope-from=ubainfo5@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic315-14.consmr.mail.bf2.yahoo.com (sonic315-14.consmr.mail.bf2.yahoo.com [74.6.134.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9CABA10FC5456
	for <linux-nvdimm@lists.01.org>; Tue,  8 Oct 2019 17:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570579569; bh=4UfWAW/NtmqJ16MbbnhDsiL2QvpdPoVJwtmjePg/DX0=; h=Date:From:Reply-To:Subject:From:Subject; b=k9eAp3fQNyJWifNCjQej3wat7ZsUYvQMP/6IOjFJoW8+L8ou5rmNMiKySjPLaWAFxmjuSgxZxRsmuZvAFaCTboDPbMeCt7JV0pnIf8n+rxwuykMm9paAf+0ybSQhESW3WrpFPCNKSZSbbzpsgNz53vERZOSZ6WlvbF3cZF99iNsxQoQtVVck/u+4WOEP0mD0N9a3o540KwhpcVo0lBpxszVS45XA8Iq/G9E9jUOfWoiL4F70aAMrIV+ubJVYCo/8fjmZ1yWI79myK4n7TfBaUG7nR+LOeY5s2lhaTeEw+wZIvS59InpBVN1yt+3TwCek+ucwYSoup7d+fBMCwUhiUQ==
X-YMail-OSG: IwRkDmAVM1lkek0afiSCFnzbLSoFs0AhZFWKXFgwl8q1zRkNO6vI6s4xR_R6FDG
 k1oknf2F2RtgbDeRPqIsJTv.UQVh1pnPhTrUOznQk96R5LxUeVbA0_yj6LYaSz2hQrZ4doZwPQnO
 QlGmRblRvW6cz79g9DUnb6lPzRuGeu2DYFdiAP_TRLfAJrT2j01W5.eF.lU7FwRl69lNy_Q27x5k
 z0U76Zsm_gDN52B6jJdjCH2ccrv2ra.VtKQ5lQOd52.lT53pNYAVAkCeoU_iV2HQPbLrOvjJ4Mzl
 HJk1Pf1bra1OvTjm_3DPcFyS_UjE1rfJrTSMDZgCCxlcL45CL7QYr7yrU.qcwYTr3xAW16Uw9s7z
 fCjqHMr8PDlElE9BzDeiFsME4AVrRBfc6Aqk..JP18iE70usKkE2lM1dxQAW9ZCYfLltxzaUozR6
 l3ld_BNSnH.UPyQShNiiM4vwcq5cDEJXKAwkC0DfwNkWtqBq5lZWsRRWRYIDHoVu8P_aWDtl6O2y
 qTXxFaKgRHeb..BVbI19vYlii0e9MUf6Sw23luoiSMDu9uRRsw8l79lhPZAR2H5PNdVp4qjyCmuA
 45fWR.3uBwTfj6dsykgOlhIv7lq7ydOAqiG9wlQtpKZatt0Ix1Lr7Er1g52Cq50JHEMfQNq1NE62
 fIlIIRgOWWBThL5el1SHvOTvfUXZWsdgNiHg14P_xdefg5sBsefpkx74NoKd__akajipchyAH9oS
 Zpjb64ixN89KdoOsBLSR4Vnod9xh_zO3yGam0c8NoQufOb.twttSn7c4AUZnE7B4.sVOa_u1B05y
 lpMjyFQXcSnqwxzMB6Jboi9C682h6AXdYtL1c0RM_LGzfa_lRxueg1c9_PKRMg0R35Kep4QorImZ
 QGtCNPBynsaHcxm2UsAAlZhtDYZ.ypxwlyG50HvrmnUImg5rjSSkH4pWb4S8SuxH7rosvmzw66xr
 _nrwdcy12UWQnt9DCq_s.JABZrAaGKQgpysjrWCQPiDaCOo..sI4iXfIAPSYbXBexvCO_7sP7MeQ
 eVBUt1LA9hP.Opm.xfDY8cAYIqHWG.Pb.Mbbbd7AY3rbHTS87g7k1cIOerzis137lEYjUNSDQu0Y
 kEHfwy_58A5_EW1iaTQlHj7GDk8tW2hZL.33FEMAh0rb.IhHI2exjh3GNBkROwWXwNZUyQQyrM3B
 iDW2YCtDWBVK7dl0uFtlvOWksQ0NM8OZJkLvPtgC_QzbvsR5_lK90Js.r.ltluzknNonPVRkvg4J
 YJl0wH4fJxbu3Sq3.SjbG.SS0P22m1gzdiVbEv3JmxHhSqKAFKw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Wed, 9 Oct 2019 00:06:09 +0000
Date: Wed, 9 Oct 2019 00:06:08 +0000 (UTC)
From: houssa mohamed <ubainfo5@yahoo.com>
Message-ID: <2087671315.3616261.1570579568220@mail.yahoo.com>
Subject: Mr. Houssa Mohammed
MIME-Version: 1.0
Message-ID-Hash: VUT3DZKVTUROJZTVHKVEAXSCLMGHI7C5
X-Message-ID-Hash: VUT3DZKVTUROJZTVHKVEAXSCLMGHI7C5
X-MailFrom: ubainfo5@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: houssamohamed790@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VUT3DZKVTUROJZTVHKVEAXSCLMGHI7C5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



From the Desk of Mr. Houssa Mohammed
(BOA)Bank of Africa.
Read and Reply to my Pravite Email( houssamohamed790@gmail.com )

Dear friend,
I am Mr. Houssa Mohammed , The head of file department of Bank of Africa
(BOA) Here in Burkina Faso / Ouagadougou. In my department we discover
an abandoned sum of (US$11.million US DOLLARS) (Eleven million US
DOLLARS) in an account that belongs to one of our foreign customer who
died in a plane crash along with his family. Since 1996.i Want you to
come and stand as next of kin to achieve this fund since you are a
foreigner my bank will be convince and approve the fund to you. Write
me here (houssamohamed790@gmail.com) while I will deals you more whenever
I receive your respond to my offer. Call my private mobile line which
is +226 67 11 27 67

i wait to hear from you sooner to enable us process the transfer to
your account.
Thanks and God bless you,
Best regards,
Mr. Houssa Mohammed
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
