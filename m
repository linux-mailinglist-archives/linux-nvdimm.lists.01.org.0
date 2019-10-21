Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD34DF595
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Oct 2019 21:03:39 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C2B291007B1F5;
	Mon, 21 Oct 2019 12:04:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=jmoyer@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 31E2D100792EA
	for <linux-nvdimm@lists.01.org>; Mon, 21 Oct 2019 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1571659665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZW2w85TwEDR7o6SJHU50uEOcHT5Iw+gP89ZUiYLiLY=;
	b=VPFLCqVKXG8ryyFxNxlnPORr0JlIJNViViCFzDv37GpQsfm6u2b14Mu74w+Mp3Yo3Tyxqd
	IB6TIMXo0yvznjnIXbyY8XjtSwNZDNZcaLFD4o+YyYaEHNeoihvIoN0l1pqPXb4d029Gzt
	Fw5YNRpffwxHOVQobhhADpkGi0K0QYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-tqajfzzvNaaD0mZxWWnBcg-1; Mon, 21 Oct 2019 08:07:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C8EF800D41;
	Mon, 21 Oct 2019 12:07:40 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CAC25D9E2;
	Mon, 21 Oct 2019 12:07:38 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] fs/dax: Fix pmd vs pte conflict detection
References: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Mon, 21 Oct 2019 08:07:38 -0400
In-Reply-To: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
	(Dan Williams's message of "Sat, 19 Oct 2019 09:26:19 -0700")
Message-ID: <x495zkii9o5.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: tqajfzzvNaaD0mZxWWnBcg-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: 2RINEA6VRU3QELET7LFPTAMG7VJB2JWN
X-Message-ID-Hash: 2RINEA6VRU3QELET7LFPTAMG7VJB2JWN
X-MailFrom: jmoyer@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, Jeff Smits <jeff.smits@intel.com>, Doug Nelson <doug.nelson@intel.com>, stable@vger.kernel.org, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2RINEA6VRU3QELET7LFPTAMG7VJB2JWN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> Check for NULL entries before checking the entry order, otherwise NULL
> is misinterpreted as a present pte conflict. The 'order' check needs to
> happen before the locked check as an unlocked entry at the wrong order
> must fallback to lookup the correct order.

Please include the user-visible effects of the problem in the changelog.

Thanks,
Jeff

>
> Reported-by: Jeff Smits <jeff.smits@intel.com>
> Reported-by: Doug Nelson <doug.nelson@intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 23c84eb78375 ("dax: Fix missed wakeup with PMD faults")
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/dax.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index a71881e77204..08160011d94c 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -221,10 +221,11 @@ static void *get_unlocked_entry(struct xa_state *xas, unsigned int order)
>  
>  	for (;;) {
>  		entry = xas_find_conflict(xas);
> +		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> +			return entry;
>  		if (dax_entry_order(entry) < order)
>  			return XA_RETRY_ENTRY;
> -		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)) ||
> -				!dax_is_locked(entry))
> +		if (!dax_is_locked(entry))
>  			return entry;
>  
>  		wq = dax_entry_waitqueue(xas, entry, &ewait.key);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
