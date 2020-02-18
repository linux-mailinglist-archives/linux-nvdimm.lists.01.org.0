Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5172E163645
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 23:36:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AA93410FC3419;
	Tue, 18 Feb 2020 14:37:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C104C10FC340F
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 14:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582065393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3WNoUEIqcbYKouLo/EQQMkIJfp174JRX5qaw1kSOS8=;
	b=ekweasWgCLkkA6hOIGzSiWjj2Wupaq1D4a576SXlolgCskuKEsKE2cZs050ScdlNoBv/31
	w4JSvhSM0dVgfFefv7Rbsv37HVZhJdaXEw4eJnftvgbt0PIyRf4LTEg4qa8loSxhUO1X1b
	JCZOs4HFLvMvoslqa3VEw4CKv3NDLyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-iDa-F9VRNKyU6m9q9s1Afw-1; Tue, 18 Feb 2020 17:36:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D62C1800D53;
	Tue, 18 Feb 2020 22:36:28 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E1BE19756;
	Tue, 18 Feb 2020 22:36:27 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl V2] namespace/create: Don't create multiple namespaces unless greedy
References: <20191206053520.235805-1-santosh@fossix.org>
	<CAPcyv4gh0yJ62Ki2NWmRDOiinqiv2v_snQ3_JWNhqVMfLCQ6Rg@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 18 Feb 2020 17:36:26 -0500
In-Reply-To: <CAPcyv4gh0yJ62Ki2NWmRDOiinqiv2v_snQ3_JWNhqVMfLCQ6Rg@mail.gmail.com>
	(Dan Williams's message of "Tue, 10 Dec 2019 11:02:11 -0800")
Message-ID: <x49y2sza5g5.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: iDa-F9VRNKyU6m9q9s1Afw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: A3CMOFOXSADQ3O7MCHOSS46MM4EJUXG6
X-Message-ID-Hash: A3CMOFOXSADQ3O7MCHOSS46MM4EJUXG6
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Vaibhav Jain <vaibhav@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A3CMOFOXSADQ3O7MCHOSS46MM4EJUXG6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

>> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
>> index 7fb0007..b1f2158 100644
>> --- a/ndctl/namespace.c
>> +++ b/ndctl/namespace.c
>> @@ -1388,11 +1388,9 @@ static int do_xaction_namespace(const char *namespace,
>>                                         (*processed)++;
>>                                         if (param.greedy)
>>                                                 continue;
>> -                               }
>> -                               if (force) {
>> -                                       if (rc)
>> +                               } else if (param.greedy && force) {
>>                                                 saved_rc = rc;
>> -                                       continue;
>> +                                               continue;
>
> Looks good, applied.

Where?

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
