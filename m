Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8D15F86A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Feb 2020 22:04:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3C5DB10FC33FF;
	Fri, 14 Feb 2020 13:07:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6603D1003EC45
	for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 13:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581714234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aaA9LekCmNuBy6+PZz+0QRYJRt8cF6I6ybrh5R8vzNo=;
	b=QIeNeLtbz5etC2TaWlhPTSthdTwgZh7XaPyr4G6Fe4OV1TJcKG2sx65XnTLpr0dT2LGJBC
	YdfIaQDNisOnsJlrCC0pPpxm4VnmXRf1vHp41aJT7e6lPJfdiEFLB6xpVId/AoSWsp6Plb
	ngFSQ7ZBtef3UrMOOQQAARKVUf32PSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-dd6hp9UGPKSx7KxtkKukFA-1; Fri, 14 Feb 2020 16:03:50 -0500
X-MC-Unique: dd6hp9UGPKSx7KxtkKukFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9773318C43C8;
	Fri, 14 Feb 2020 21:03:48 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B4B628AC4D;
	Fri, 14 Feb 2020 21:03:47 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 0/4] libnvdimm: Cross-arch compatible namespace alignment
References: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 14 Feb 2020 16:03:47 -0500
In-Reply-To: <158155489850.3343782.2687127373754434980.stgit@dwillia2-desk3.amr.corp.intel.com>
	(Dan Williams's message of "Wed, 12 Feb 2020 16:48:18 -0800")
Message-ID: <x49blq0dgp8.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: VFW3WBQKMV4Y7TLLSJHP4LNSIL7N676O
X-Message-ID-Hash: VFW3WBQKMV4Y7TLLSJHP4LNSIL7N676O
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VFW3WBQKMV4Y7TLLSJHP4LNSIL7N676O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> ---
>
> Explicit review requests, but any other feedback is of course
> appreciated:
>
> Patch1 needs an ack from ppc arch maintainers, and I'd like a tested-by
> from Aneesh that this still works to solve the ppc issue. Jeff, does
> this look good to you?

OK, I've reviewed everything.  Testing looks good with the change I
mentioned (memremap_compat_align returning PAGE_SIZE).  I made sure a
4k-aligned namespace created under an unpatched kernel would be
accessible under a patched kernel.  I also made sure that manually
setting align would allow for creating of poorly aligned namespaces, and
that those namespaces were then accessible on the unpatched kernel.

Thanks, Dan!

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
