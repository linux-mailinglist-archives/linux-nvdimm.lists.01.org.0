Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08431164E8E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 20:10:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A398F10FC3412;
	Wed, 19 Feb 2020 11:11:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2916D10FC3411
	for <linux-nvdimm@lists.01.org>; Wed, 19 Feb 2020 11:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582139451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQmhr9Kh6qyrmW8oniB3vRQDzLQuXLnoe/4D8hSgJPE=;
	b=NyYSqLCCztevnaYbusUwCQ6BRYncwiGgdD+QEgNoyPiu/qgXq3qOD1csIIvZJ0yhSiPy3S
	03c7e5kiCFuNl5TV3uWtlccNoVJ8q+4q+kt2bfdzQDKV2zW7g6ih//vsDzGNymIwgKl0Jr
	+oFRy/pXKmr8q50CqEmHTnFEUjA2IhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-iml3DmjrO4K7z9MBXtRYDQ-1; Wed, 19 Feb 2020 14:10:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03853100550E;
	Wed, 19 Feb 2020 19:10:39 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A821290768;
	Wed, 19 Feb 2020 19:10:38 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] ndctl/list: Drop named list objects from verbose listing
References: <157481532698.2805671.8095763752180655226.stgit@dwillia2-desk3.amr.corp.intel.com>
	<x49sgj6law0.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4ibE3ssieq=A5diqwRyiT6e3X=kcpQ3aA0vYneBpuSCAA@mail.gmail.com>
	<x49k14ila4r.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4hHU+RC6TZW94UrjFJZ1fsOU8Nug0GP+Mb5mBGW8qk+UQ@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Wed, 19 Feb 2020 14:10:37 -0500
In-Reply-To: <CAPcyv4hHU+RC6TZW94UrjFJZ1fsOU8Nug0GP+Mb5mBGW8qk+UQ@mail.gmail.com>
	(Dan Williams's message of "Wed, 19 Feb 2020 10:53:41 -0800")
Message-ID: <x49d0aal7f6.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: iml3DmjrO4K7z9MBXtRYDQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: OK4SOIXEM6AIWX5UXHPM267SDR5LMU2R
X-Message-ID-Hash: OK4SOIXEM6AIWX5UXHPM267SDR5LMU2R
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OK4SOIXEM6AIWX5UXHPM267SDR5LMU2R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

>> >> Will this break existing code that parses the javascript output?
>> >
>> > Always a potential for that. That said, I'd rather attempt to make it
>> > symmetric and replace it if someone screams, rather than let this
>> > quirk persist because it makes it impossible to ingest region data
>> > with the same script across -R and -Rv.
>>
>> Yeah, I see where you're coming from.  However, script authors will
>> still have to deal with older versions of ndctl in the wild (for many
>> years).  If the decision was up to me, I'd live with the wart in favor
>> of not breaking scripts when ndctl gets updated.  Users hate that.
>
> Let's do a compromise, because users also hate nonsensical legacy that
> they can't avoid. How about an environment variable,
> "NDCTL_LIST_LINT", that users can set to opt into the latest /
> cleanest output format with the understanding that the clean up may
> regress scripts that were dependent on the old bugs.

Deal.  :)

-Jeff
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
