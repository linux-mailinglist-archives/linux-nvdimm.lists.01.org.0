Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC992869C4
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 23:00:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C5F541569CC43;
	Wed,  7 Oct 2020 14:00:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.38.202.179; helo=cha5.chairmaneventsummit.info; envelope-from=info-linux+2dnvdimm=lists.01.org@chairmaneventsummit.info; receiver=<UNKNOWN> 
Received: from cha5.chairmaneventsummit.info (ip179.ip-54-38-202.eu [54.38.202.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A26F31568E4ED
	for <linux-nvdimm@lists.01.org>; Wed,  7 Oct 2020 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=chairmaneventsummit.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=info@chairmaneventsummit.info;
 bh=ILXfKhczvQLExCdmmyHRNf+cj+M=;
 b=dtFERzPrxJlMW/UTUDuVCcNpKOhoOV9Wd7KGryNs0SpTQ4sDC5IgNagU3Rd1qbwGgF7NFtOLYVxH
   yEhZwslMyb5jb3zmUeX70DrHLfOzp+IQc+BbyuxSMoKeYjcxLV9pzSKY8fIzI4Jpa1J2XGX+ISXB
   cM8O91AM6Yqrqyzuly16oUPdIZTUJJ1p8yExo6nqP7U6OGRxbmrulFcXJDu2vjMX9iDyNViKesol
   /zBT3BOYiFQw4ZB/HmbLUjgvlw3fTFm1EJHI/w+dRdO5v3Ulg0Yql3Ru/rYsWLu0wMiXn4OPC6VJ
   kRVyLOKccxIij4ibmvurRlpb0ijV6B+/gkHiwg==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=chairmaneventsummit.info;
 b=mTpNP6Nt2BuiyTWFwuCnSkvlsNP8+NA2H6uvcpq1eCIxAY7OJ94qnKeHTd5i4clZtFQexZG7EMgi
   xU/w7l6ZWDGoC+7yX2QuosDFxV5j/u/VDRnLC2B+bkZ4Wo8x+pX+ats7c2NDH6sAUbC08ujpxne2
   H7bZhY80JZv9i59WR5lTJci2/+k2KP3RBg9k5ftUNjisaIMoTC8mNY2sSQKLflbLT+RNbvDPWk9S
   5AKjQU1B0bqvONSOZbbRO4wTDu0+myFGTG62TkNsE37Wu+wdSL+LYPXEQPIt38x5CpvldnOmj6CZ
   asgzKDIa0ouZuTU7mOZ0QfGa2javN6hjRrNwjA==;
Received: from chairmaneventsummit.info (51.83.131.67) by cha1.chairmaneventsummit.info id hfom6ji19tkm for <linux-nvdimm@lists.01.org>; Wed, 7 Oct 2020 20:57:44 +0000 (envelope-from <info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info>)
Date: Wed, 7 Oct 2020 20:57:44 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Emma Johnson <info@chairmaneventsummit.info>
Subject: RE: 10 Leads and Scheduled appointments at 1k
Message-ID: <5daf1a11d6c5e67e9fd420d269d767df@chairmaneventsummit.info>
X-Trgm-Campaign-Uid: cg2957b95t752
X-Trgm-Subscriber-Uid: ek460shgxm55f
X-Trgm-Customer-Uid: cl716wf5hl7c7
X-Trgm-Customer-Gid: 0
X-Trgm-Delivery-Sid: 1
X-Trgm-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: https://chairmaneventsummit.info/emm/index.php/campaigns/cg2957b95t752/report-abuse/ks05428k240e4/ek460shgxm55f
Feedback-ID: cg2957b95t752:ek460shgxm55f:ks05428k240e4:cl716wf5hl7c7
Precedence: bulk
X-Trgm-EBS: https://chairmaneventsummit.info/emm/index.php/lists/block-address
X-Sender: info@chairmaneventsummit.info
X-Receiver: linux-nvdimm@lists.01.org
X-Trgm-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: 5TJNM52LV6L26NXY33DZE62QLX5PHT5J
X-Message-ID-Hash: 5TJNM52LV6L26NXY33DZE62QLX5PHT5J
X-MailFrom: info-linux+2Dnvdimm=lists.01.org@chairmaneventsummit.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Emma Johnson <emma@ceoeventsummit2020.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5TJNM52LV6L26NXY33DZE62QLX5PHT5J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Did you get my previous emails?
Proposal 1:10 Leads generated from email marketing to your target
audience at $1,000
Proposal 2:10 Scheduled appointments from Tele calling to your target
audience at $1,500
We have targeted database from your industry and we just need your
service/sales pitch, we will create an email pitch and tele calling
script. Share with you before we start sending that to your target
audience to generate Leads or queries.
Please reply to this email if wish to know more about this Lead
generation. Also if you can share your target audience details like
titles/industry/location or type of audience you target for your
business.
Thanks,
Emma Johnson
Lead generation Team
Email Marketing Inc
https://chairmaneventsummit.info/emm/index.php/lists/ks05428k240e4/unsubscribe/ek460shgxm55f/cg2957b95t752

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
