Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B271163454
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 22:09:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 06B9E10FC3405;
	Tue, 18 Feb 2020 13:10:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7204A10FC33FD
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 13:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582060182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E9mRKEIAjKB1Xq/wMpY1paNLH79mcLaPS2RPUKkvMDQ=;
	b=PIKIBcXXV5icRXnBUto48WVeEz7JlejGzH9QixoY2on11Zwy4OnlJMUM3PdphJm69+L+qM
	kmgGnu7omAxZY8QDPP+v2oZFiD4hdwC48TfAucvhtlnBvntR7AAkapQ70lB4Z7IR59UYD1
	gZzs7OMMTv5YmAfzUPF1vSmCahJGUoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-D5lFg6opNpGvWSZgTdsX6A-1; Tue, 18 Feb 2020 16:09:34 -0500
X-MC-Unique: D5lFg6opNpGvWSZgTdsX6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EA32DBA3;
	Tue, 18 Feb 2020 21:09:32 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A890060BE1;
	Tue, 18 Feb 2020 21:09:31 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm: get rid of WARN if failed to cow user pages
References: <20191225054227.gii6ctjkuddjnprs@xzhoux.usersys.redhat.com>
	<CAPcyv4hMPh0C+_OV+vuiYQikb8ZvRanna4vXfKN=10yrAyCjDA@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Tue, 18 Feb 2020 16:09:30 -0500
In-Reply-To: <CAPcyv4hMPh0C+_OV+vuiYQikb8ZvRanna4vXfKN=10yrAyCjDA@mail.gmail.com>
	(Dan Williams's message of "Tue, 14 Jan 2020 22:02:34 -0800")
Message-ID: <x49imk3bo1h.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: BEMM6556QQ2EXG3TZUPK54QXNDPUZQTR
X-Message-ID-Hash: BEMM6556QQ2EXG3TZUPK54QXNDPUZQTR
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Jia He <justin.he@arm.com>, Linux MM <linux-mm@kvack.org>, "Shutemov, Kirill" <kirill.shutemov@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BEMM6556QQ2EXG3TZUPK54QXNDPUZQTR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> [ drop Ross, add Kirill, linux-mm, and lkml ]
>
> On Tue, Dec 24, 2019 at 9:42 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>>
>> By running xfstests with fsdax enabled, generic/437 always hits this
>> warning[1] since this commit:
>>
>> commit 83d116c53058d505ddef051e90ab27f57015b025
>> Author: Jia He <justin.he@arm.com>
>> Date:   Fri Oct 11 22:09:39 2019 +0800
>>
>>     mm: fix double page fault on arm64 if PTE_AF is cleared
>>
>> Looking at the test program[2] generic/437 uses, it's pretty easy
>> to hit this warning. Remove this WARN as it seems not necessary.
>
> This is not sufficient justification. Does this same test fail without
> DAX? If not, why not? At a minimum you need to explain why this is not
> indicating a problem.

I ran into this, too, and Kirill has posted a patch[1] to fix the issue.
Note that it's a potential data corrupter, so just removing the warning
is NOT the right approach.  :)

-Jeff

[1] https://lore.kernel.org/linux-mm/20200218154151.13349-1-kirill.shutemov@linux.intel.com/T/#u
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
