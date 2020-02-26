Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F0B170BCD
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Feb 2020 23:44:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 359DC10FC316A;
	Wed, 26 Feb 2020 14:45:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B23F11007B162
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582757064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgxLo9K76LyvhJ4BDhloH9VcvSgejWi/j0t5i3KBa+I=;
	b=O27H+yDpOsPUKQCQZipImPDH87+WvjnqQU8LbXYsvZXOCE5t8MqVTb2T6TWdQBr4WF9c35
	po8Qhn+Tp6IbyJtAI2jcDxHYBPNo2/mMSilLk1XpDMDgxWaW681g0X5p275nI17X8r6xzt
	OcObplhCc7zAoGwK4dFn2WiLSa3JHB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-ImriyYF7OBq1Kjyfg4iVCw-1; Wed, 26 Feb 2020 17:44:20 -0500
X-MC-Unique: ImriyYF7OBq1Kjyfg4iVCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEAE913E2;
	Wed, 26 Feb 2020 22:44:19 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17B1910027BA;
	Wed, 26 Feb 2020 22:44:19 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH 1/2] ndctl/region: Support ndctl_region_{get, set}_align()
References: <158042414995.3946705.2742716492944802875.stgit@dwillia2-desk3.amr.corp.intel.com>
	<158042415512.3946705.18330231517256727320.stgit@dwillia2-desk3.amr.corp.intel.com>
	<x49o8tulai8.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4izzfzrb2r7Mc7FfryGnBcn1bOUA8a6_L9t2fKR4caoXw@mail.gmail.com>
	<x49y2sp3tka.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4j2D93E4AgzB7JN51e18L85zmkLGA3gCVdq5ovxXMhH0g@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 26 Feb 2020 17:44:18 -0500
In-Reply-To: <CAPcyv4j2D93E4AgzB7JN51e18L85zmkLGA3gCVdq5ovxXMhH0g@mail.gmail.com>
	(Dan Williams's message of "Wed, 26 Feb 2020 14:20:47 -0800")
Message-ID: <x49tv3d3r5p.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: L54X7PTNRROYR7QRTYDQA74PLOGTXYNG
X-Message-ID-Hash: L54X7PTNRROYR7QRTYDQA74PLOGTXYNG
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L54X7PTNRROYR7QRTYDQA74PLOGTXYNG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> On Wed, Feb 26, 2020 at 1:52 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>> >> Missing doctext.  Specifically, there should be a big, fat warning
>> >> against changing the region alignment.
>> >
>> > I don't mind adding one, but is this the right place to document an
>> > API warning? If the audience is future ndctl developers that should be
>> > warned to keep the status quo of not plumbing this capability into
>> > "create-namespace" that's one message. If it's to stop other libndctl
>> > application developers, they'll likely never see this source file.
>>
>> I meant to target users of the library (not ndctl developers).  I
>> thought that was the reason for the doctext on exported interfaces.  No?
>>
>> I admit, I don't know how users of libndctl figure *anything* out about
>> how to use it.  :)
>>
>
> Right, that's why I was confused about what you were asking. We
> haven't yet formalized a library documentation system, which is bad.
> I'll add kernel-doc for this function, and add an item to the backlog
> to figure out how to build library-documentation from those
> annotations. The developer's guide to date has unfortunately been "go
> review how ndctl uses it".

OK, thanks a lot!

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
