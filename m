Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D967B28BE80
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 18:53:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E0FD51568FCC3;
	Mon, 12 Oct 2020 09:53:40 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 701011568AEDF
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 09:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=0xPKHcc8MTxN9G6km2QTOKG69v7B4xiLbgAzISFd/e0=; b=kz3byLEjQRbXUjKEwxSctQX5ib
	JSA+qNZHtA9aewEXAvoV2M3/g5ArH8yJiAAE/kke62YDaHPl5o3/+xMrd/i+waTWdk3FhLyFNeYuc
	4Nk7+Bj9BYXz1xAwd03P2XqWJ4u6gF0YTzxkwS+nNCJwrPuiM7tYRinTk9MOFt20vbPG0TllKA7E7
	FUnU7I/afnKhT4pPw79tju4VhbduW2vl13IeqsRBdekOuYvNqMsrEYykSyc7jGqRQHVc5tHH6aPY+
	3213WdwwwrFYELr6mggaHw1E8IyEoal3f+Bv/YjhibFGCElAxvPsPRtwNZbUqKeJg0h3VUzn9VsZs
	n9KroRrg==;
Received: from [2601:1c0:6280:3f0::507c]
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kS14o-0005Ww-Nr; Mon, 12 Oct 2020 16:53:35 +0000
Subject: Re: [PATCH v2 21/22] mpool: add documentation
To: Nabeel M Mohamed <nmeeramohide@micron.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mm@kvack.org, linux-nvdimm@lists.01.org
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201012162736.65241-22-nmeeramohide@micron.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57fef732-f63d-9c9c-e368-660c654a7438@infradead.org>
Date: Mon, 12 Oct 2020 09:53:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012162736.65241-22-nmeeramohide@micron.com>
Content-Language: en-US
Message-ID-Hash: DDI5L5MESWIHNE7G2FIZPOTBFHKUSNHO
X-Message-ID-Hash: DDI5L5MESWIHNE7G2FIZPOTBFHKUSNHO
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DDI5L5MESWIHNE7G2FIZPOTBFHKUSNHO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> diff --git a/drivers/mpool/mpool-locking.rst b/drivers/mpool/mpool-locking.rst
> new file mode 100644
> index 000000000000..6a5da727f2fb
> --- /dev/null
> +++ b/drivers/mpool/mpool-locking.rst
> @@ -0,0 +1,90 @@

> +Object Layout Reference Counts
> +------------------------------
> +
> +The reference counts for an object layout (eld_ref) are protected
> +by mmi_co_lock or mmi_uc_lock of the object's MDC dependiing upon

                                                     depending

> +which tree it is in at the time of acquisition.

-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
