Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE03530A7
	for <lists+linux-nvdimm@lfdr.de>; Fri,  2 Apr 2021 23:17:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB655100EAB5F;
	Fri,  2 Apr 2021 14:17:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.178; helo=mail-oi1-f178.google.com; envelope-from=hughd@google.com; receiver=<UNKNOWN> 
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AD8EA100EF264
	for <linux-nvdimm@lists.01.org>; Fri,  2 Apr 2021 14:17:17 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id n8so6009003oie.10
        for <linux-nvdimm@lists.01.org>; Fri, 02 Apr 2021 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EuMNzSviNgVTCMigCRn9biGypSs6VLzXgTTmdNbGnM0=;
        b=X/QMAEI97fgJ80rjf5uFusAtG4H/6OuS9yml3Iu4aBdSHgjhorK2ZE4AgLosnrcs9R
         JPRqXF1gOO4T/2rvF9wjHpJyfEW9Idw5AVyrsqt0KIgzU4QrHwOxF3Mk7mXfA0c3266/
         B2Sr+4xkGTLkp919H+ZpuV6vjm/v5KZLF0Z5s//CKlQJ3z/TAzLBYO8CvEkxsifUM2ch
         4hxs8LqAlRV1ehfc/cx7r3/aK9HkSCvTaF8LaoXeNMAdESRI+2JD7AOkRCyHmWwzgH9L
         kt0JoL74GWXs0hgNp27lO0SZdIGzCsX4lG23THqAFFz07Wdli/Ze0jnhzV3P8D0SiFO2
         BW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EuMNzSviNgVTCMigCRn9biGypSs6VLzXgTTmdNbGnM0=;
        b=hKEcB5I8tV4eFTzn5nFgQvKViqmZDfddeYMGDz0XJf4vUQVU08tIi8Pd7i7s5nAP6S
         gkMXT1VID4UcSe3cgw2nMFDrGYqApn/7CGHiV8bFpXtrVwJplO1Y0uB/nDe+4MPNrKrU
         xMzREE2yapWCKIT+ncSAAquvypmWfLQRUc8XWd8yogXpLkF9L7zH0CVSQN9QC+BPwPRf
         GslrWmjUEb14lpP8E4gwFys7AXJKaoSzTgo/0syIT1YFZbt10gryC6RvXUa3gnZfZjHq
         PXSaKttlxnJfAGzxM6IB50U0y/l/dNjbqkOMJLHV5g+n2bDJoMBuQw6ACkjT/gjuUnpL
         9LMA==
X-Gm-Message-State: AOAM531pyDtJpwoRgEq2J4QXE7Fc+6zt5CJlC6lDSYryT1gPhv/Fx5Qn
	DMikwlWQxX6Lb98GNnWb5poyIg==
X-Google-Smtp-Source: ABdhPJxHoLg7Mj6MbBeuVeCELsvBwuzhCT4GwDHbTxgp/9Ssp/rTN2MV9BgkVyI0Rhfnb98rln/95w==
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr11264930oie.4.1617398176714;
        Fri, 02 Apr 2021 14:16:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e34sm2099720ote.70.2021.04.02.14.16.15
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 02 Apr 2021 14:16:16 -0700 (PDT)
Date: Fri, 2 Apr 2021 14:16:04 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
In-Reply-To: <alpine.LSU.2.11.2104021239060.1092@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2104021354150.1029@eggly.anvils>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils> <20210331024913.GS351017@casper.infradead.org> <alpine.LSU.2.11.2103311413560.1201@eggly.anvils> <20210401170615.GH351017@casper.infradead.org> <20210402031305.GK351017@casper.infradead.org>
 <20210402132708.GM351017@casper.infradead.org> <20210402170414.GQ351017@casper.infradead.org> <alpine.LSU.2.11.2104021239060.1092@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Message-ID-Hash: WKOJ6D2XZKB5YFGMNZ7RZCPOBY7XCSDK
X-Message-ID-Hash: WKOJ6D2XZKB5YFGMNZ7RZCPOBY7XCSDK
X-MailFrom: hughd@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WKOJ6D2XZKB5YFGMNZ7RZCPOBY7XCSDK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2 Apr 2021, Hugh Dickins wrote:
> 
> There is a "Put holes back where they were" xas_store(&xas, NULL) on
> the failure path, which I think we would expect to delete empty nodes.
> But it only goes as far as nr_none.  Is it ok to xas_store(&xas, NULL)
> where there was no non-NULL entry before?  I should try that, maybe
> adjusting the !nr_none break will give a very simple fix.

No, XArray did not like that:
xas_update() XA_NODE_BUG_ON(node, !list_empty(&node->private_list)).

But also it's the wrong thing for collapse_file() to do, from a file
integrity point of view. So far as there is a non-NULL page in the list,
or nr_none is non-zero, those subpages are frozen at the src end, and
THP head locked and not Uptodate at the dst end. But go beyond nr_none,
and a racing task could be adding new pages, which THP collapse failure
has no right to delete behind its back.

Not an issue for READ_ONLY_THP_FOR_FS, but important for shmem and future.

> 
> Or, if you remove the "static " from xas_trim(), maybe that provides
> the xas_prune_range() you proposed, or the cleanup pass I proposed.
> To be called on collapse_file() failure, or when eviction finds
> !mapping_empty().

Something like this I think.

Hugh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
