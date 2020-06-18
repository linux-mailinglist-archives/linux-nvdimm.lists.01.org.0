Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0EF1FFA68
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jun 2020 19:37:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8A90F10FC546E;
	Thu, 18 Jun 2020 10:37:05 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=77.238.176.206; helo=sonic306-20.consmr.mail.ir2.yahoo.com; envelope-from=daniel.patrick101@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic306-20.consmr.mail.ir2.yahoo.com (sonic306-20.consmr.mail.ir2.yahoo.com [77.238.176.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 662D110FC4F75
	for <linux-nvdimm@lists.01.org>; Thu, 18 Jun 2020 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592501822; bh=fH/bCqhO+/rdrFrxud7WLZNywhlisn3LiimgndMH2Zo=; h=Date:From:To:Subject:References:From:Subject; b=dhzNsRC+hfMWqq5Mu15dM/9ZQ2TR07gmhGsU+eQLOZitOqZNRPPVzNFsdHy+2I0DPRWlwrG18utoBE9NYgpI3gEj3mduLQ6JVh+RX7HRYOjv2MUqZRWTbqXHgEvHV3v/ZeewCQlYNTcETkheiJHi9WxeIZ/E7UlF0urccm1FJfyDn8Vr3Of0yY/n6UA+1Aq6UPBz0p6JB+VZRqvM56n9yXD2qqOvlFLsnLMQGIT1sxq0Lh44Ht4iOajHTxprvR0qFWqwSoL6Er/YiRQcDLIB28sfBXLDcwmgjXgNv7BKx5HCno3XMP9J3elizgWLTNxo/aHJzi79q2OZtg1YednBAw==
X-YMail-OSG: 5xYZTPAVM1k.Z_SPnakSFLBCGUlwyWAwgRgn.QGaWDi5XrMinCnkg5P9XEolHTY
 zxkTYZFOxFtiGVQ157dKB9UD28lfLfKwHeW1JfHvLsx1Q3KZX73YPwBagwsNr48N29yjKZf.kksP
 i5cguoFze87oh4jIt.Pns74mdP2EbY.XPF2U.sV8NPFQzStEPGGlPIjZzKfCmCNenshwRuWS64VZ
 JcxHzsIUmMTmXEu9E2mMN5c732VJUc0XYstt3jIWpKNE75x9k7H_EylTcXyFUpvf5FW9.9aAZzr7
 zHszxXNKKd.BgVcfGZ8jwAD6vIrXY716Ua6BhE_WKr53942r1TZ.JyN3Ge0w6SlHJWwYFPypd4lb
 qcvZRQfl4ReFLT5UttJ9Uibhsvej5ph8oXaTy0klAJZueV9TL.52np.9Vtr2Wp0GYq7c7hymTwDE
 1YS2h3SrpmH_oBjiQzXkQqpQzIhou2G2fxXHBgpZo7Wb9V2wag20pWaq4afzYVVuuwS2BlcF1RUN
 BR6jUSyPb2oFztTlljHQdR8jqDqe0n9c4bC8UUlTClDgl5G4DYx3gODlS0YwcnFf324Se6sXlAu3
 z364NNxKqCXm72fAw2L0lFrGXqOdmsWIGX9iSrhHOStQ_ulXCB2Lo9E7TmHyyscCLSzmaFP15C7d
 R12H.228Z1yi9ObovKz3Tqric5yh672_xUKDUEYmZ1YzU52e0GHJvNkZKm.cIZMxVQv1imeHIHEO
 iIV8x.teG7Yv.KK6RlMoMOCVsm.La6TtZYFPYZyn9WPpd1DlDg8TJykLLtf4H7CoVQXst4vr9vqs
 ypKIUTSsvLNBsSD6BLCA1DD02NEDAoI_kU2iVSm7g2p4WQFkv78DyaqsXp7YvKVYKWdzFhh7Zt4T
 WEbl1Ej.XuTSJkI_QmXEWVxidPa4YGsPEjuCpf.8x87QKYeRGZF88S2ayIJpA9qSwORQUbkrxwcv
 n82agq9dSHDPsNaAAMnb9Nw8_Wmz1ZBDvKN1QWARLOxXieZRRkhP1QJOZyMwxZ42ezm1PNZ.5Gr4
 TLH6M2GblXq2FA_T0FRYvpy0Vxih3Oha18CAmybomeBgwLvWlINYQyURPPle1Lud19MS2kifypR.
 vZ251TgqVoC.nLeMphiDcGWx8TE.elrCC.HDt4IaYp_0WZ4UKhw9S2VS0r7hUgNSI.mX7CE8Q4sh
 SMVMUOW74Ftyp7w7Sr9wVFisVXhUPWs.IbuIwp2jQTCnsmL09hS8lFvunPQHXG15B8pk3HKlzTdF
 G2.JwKGTHKHuTLbqdbb5Ms6mEEmu_TbaFQYZaYzFIvUcak4VMZNJORVVsKtjPJMUI.9R0LDJs.O0
 _ctvvOZeJRHBevsNbuhep_oGDxQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Thu, 18 Jun 2020 17:37:02 +0000
Date: Thu, 18 Jun 2020 17:37:00 +0000 (UTC)
From: Daniel Patrick <daniel.patrick101@yahoo.com>
To: daniel.patrick101@yahoo.com
Message-ID: <1829951013.810112.1592501820172@mail.yahoo.com>
Subject: Good News Dear Good Friend,
MIME-Version: 1.0
References: <1829951013.810112.1592501820172.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; GTB7.5; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; InfoPath.2)
Message-ID-Hash: 72MEPLGGWNOUMGFIO227MUM343KLXWPD
X-Message-ID-Hash: 72MEPLGGWNOUMGFIO227MUM343KLXWPD
X-MailFrom: daniel.patrick101@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/72MEPLGGWNOUMGFIO227MUM343KLXWPD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Good News Dear Good Friend,

I am happy to inform you about my success in getting those funds transferred under the co-operation of a new partner from Germany.

Presently I'm in Germany for investment projects with my own share of the total sum. Meanwhile, I didn't forget your past efforts and attempts to assist me in transferring those funds despite that it failed us some how, now contact my Lawyer through his contact details here below THOUGH he is in Africa Ivory Coast.

Name: Barrister Ego Amaka
Tel: +225 55 66 29 45
Email:  barristeregoamaka@yahoo.fr

He is in Abidjan Ivory Coast, his name is Barr. Ego Amaka, ask him to send you the Cheque of $150,000.00 USD (One Hundred and Fifty Thousand United State Dollars) which i kept for your compensation for all your past efforts and attempts to assist me in this matter. I appreciated your efforts to help me at that time very much.

Feel free and get in touch with him and please do let me know immediately you receive the Cheque so that we can share the joy together after all the suffering at that time. at the moment, I'm very busy here because of the investment projects which I and my new partner are having at hand now.

I have forwarded instruction to my Lawyer on your behalf to receive the cheque, so feel free to get in touch with him, he will send it to you without any delay.

For your information, I gaved the Lawyer $100 USD incase of any expences during the Cheque delivery to you in your country please take note.

Remain Blessed
Daniel Patrick.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
