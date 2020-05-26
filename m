Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CCE1E3043
	for <lists+linux-nvdimm@lfdr.de>; Tue, 26 May 2020 22:49:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0971012233838;
	Tue, 26 May 2020 13:45:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0C4A12227BD5
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1590526179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7PjyR/8o3dtBnugjx2KYf37YAbRvISSRvlghHLQ8LU=;
	b=BZxxUGlR3WeG3Cv/UJhvifuhaU4mQnJDJgF6gxGJyuJA9udLX0PxkcfgFy3fmC8cp4orUx
	5lA2PMuPoqm12hX96HbuKe/TjP6pI4EZNLjAW2/bopZcRAjiHRqD40nK6c+YTu4AalTtMV
	i473g7um6JAyJE3Fb7RYMJF24Kban8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-HM0L2WrZPOmrdVHO2sL7pg-1; Tue, 26 May 2020 16:49:35 -0400
X-MC-Unique: HM0L2WrZPOmrdVHO2sL7pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C62A380183C;
	Tue, 26 May 2020 20:49:33 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E54119D61;
	Tue, 26 May 2020 20:49:31 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [5.4-stable PATCH 0/7] libnvdimm: Cross-arch compatible namespace alignment
References: <159010426294.1062454.8853083370975871627.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20200522115800.GA1451824@kroah.com>
	<20200522120009.GA1456052@kroah.com>
	<CAPcyv4jW9P2FP2p6OiLoN+e_wzZY9-c8C-mMMoDqohuTekF7WQ@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 26 May 2020 16:49:30 -0400
In-Reply-To: <CAPcyv4jW9P2FP2p6OiLoN+e_wzZY9-c8C-mMMoDqohuTekF7WQ@mail.gmail.com>
	(Dan Williams's message of "Tue, 26 May 2020 13:42:44 -0700")
Message-ID: <x491rn6a0bp.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: OTY3FRSESZLV4WTW5IXTZ6SZMTNTRJXT
X-Message-ID-Hash: OTY3FRSESZLV4WTW5IXTZ6SZMTNTRJXT
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Greg KH <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OTY3FRSESZLV4WTW5IXTZ6SZMTNTRJXT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

>> What problems with 5.4.y and 5.6.y is this series fixing
>> that used to work before?
>
> The "used to work" bug fixed by this set is the fact that the kernel
> used to force a 128MB (memory hotplug section size) alignment padding
> on all persistent memory namespaces to enable DAX operation. The
> support for sub-sections (2MB) dropped forced alignment padding, but
> unfortunately introduced a regression for the case of trying to create
> multiple unaligned namespaces. When that bug triggers namespace
> creation for the region is disabled, iirc, previously that lockout
> scenario was prevented.
>
> Jeff, can you corroborate this?

So, I don't pretend to remember the exact state of brokenness for each
iteration.  :)  As far as I can recall, though, the issue you describe
with a misaligned namespace preventing further namespace creation was
present in all kernels up until it was finally fixed.

> I otherwise agree, if the above never worked then this can all wait
> for v5.7 upgrades.

I can test specific kernel versions if that would help out.

Cheers,
Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
