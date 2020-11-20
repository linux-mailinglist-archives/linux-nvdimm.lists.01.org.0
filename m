Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 314312BB0DC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 20 Nov 2020 17:45:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5143A100EC1F8;
	Fri, 20 Nov 2020 08:45:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B5D33100EF241
	for <linux-nvdimm@lists.01.org>; Fri, 20 Nov 2020 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1605890731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kQ5lD4semljT0hlUPgMth9FP++TcILdikKHhA/smer4=;
	b=DjI8fpHqX+wS693WGNc3yPFErSvs+ne0bsCuhAk820huigONg+Z8Q7m7s7K7IlPGp9Cqmj
	8xAU3+NPfMr4G6Erlm1eTy3nuMT6CFu9d35bV9ePMMd/T1/wUQUYCYO1zADoOL1PXNbihz
	lcN8ArZ80SE4mVxkp1DYwpY7YHu5iKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-EvNvjEVsNUilS1SwzsNc3Q-1; Fri, 20 Nov 2020 11:45:29 -0500
X-MC-Unique: EvNvjEVsNUilS1SwzsNc3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1FBC1895FE6;
	Fri, 20 Nov 2020 16:45:28 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F72F5D6BA;
	Fri, 20 Nov 2020 16:45:28 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: Re: [ndctl PATCH 0/8] fix serverl issues reported by Coverity
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Fri, 20 Nov 2020 11:45:32 -0500
In-Reply-To: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com> (Zhiqiang Liu's
	message of "Fri, 6 Nov 2020 17:23:23 +0800")
Message-ID: <x49mtzcm0yb.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmoyer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: 6GPNOL37N6JPAJMEB57NRCPJUMMYWLWO
X-Message-ID-Hash: 6GPNOL37N6JPAJMEB57NRCPJUMMYWLWO
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linfeilong <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6GPNOL37N6JPAJMEB57NRCPJUMMYWLWO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Zhiqiang Liu <liuzhiqiang26@huawei.com> writes:

> Recently, we use Coverity to analysis the ndctl package.
> Several issues should be resolved to make Coverity happy.
>
> lihaotian9 (8):
>   namespace: check whether pfn|dax|btt is NULL in setup_namespace
>   lib/libndctl: fix memory leakage problem in add_bus
>   libdaxctl: fix memory leakage in add_dax_region()
>   dimm: fix potential fd leakage in dimm_action()
>   util/help: check whether strdup returns NULL in exec_man_konqueror
>   lib/inject: check whether cmd is created successfully
>   libndctl: check whether ndctl_btt_get_namespace returns NULL in
>     callers
>   namespace: check whether seed is NULL in validate_namespace_options
>
>  daxctl/lib/libdaxctl.c |  3 +++
>  ndctl/dimm.c           | 12 +++++++-----
>  ndctl/lib/inject.c     |  8 ++++++++
>  ndctl/lib/libndctl.c   |  1 +
>  ndctl/namespace.c      | 23 ++++++++++++++++++-----
>  test/libndctl.c        | 16 +++++++++++-----
>  test/parent-uuid.c     |  2 +-
>  util/help.c            |  8 +++++++-
>  util/json.c            |  3 +++
>  9 files changed, 59 insertions(+), 17 deletions(-)

Except for the minor nit I pointed out, for the  series:

Acked-by: Jeff Moyer <jmoyer@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
