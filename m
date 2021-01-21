Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 860D32FF61F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 21:42:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 79A4A100F2251;
	Thu, 21 Jan 2021 12:42:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=hannes@cmpxchg.org; receiver=<UNKNOWN> 
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F2E1C100F2250
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 12:42:35 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id r77so2877488qka.12
        for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/cN+TIyFlXTYzj8exXBqwp7S9shR8K+JZFzTefh5owU=;
        b=tCnozVcakStoR6Ant0DnFGkC2zcvbtAQ+2Wx5n2GAa4iQsm/U/7xWnm/XNw80wd0oV
         m3BHXk/kskullDm/TF1t9Km9gNBOyz4pWGkiIwNPSzh2VpWKJBeDzuGTvbBM5kU7bf4d
         SzZukFdyF5QQim7GxlqmNWl4o4DIwD2fJ4d+4PL7M9C6Qqcqt7NVAZXwyx6yDUMWfJFw
         M1kWz250Rxt9/5/u0KnJlB6FWCSxvgZz3fLnm9oJElp6C9xu/77/a88LO2JJbX7r8dvd
         Gw0eIfKRp9to3eg1VWdHdPYUIQxaG9oq5EsGqNADGB4iKZmpE/UC9mQUCAQD+SRxcOOp
         L+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/cN+TIyFlXTYzj8exXBqwp7S9shR8K+JZFzTefh5owU=;
        b=ev31A3swhVXyIkVp/bXl6Wny4AShvWqIh3hxri0mURMVnCSHTs9HlLjE5dO4Yy9hmv
         vUBvi1z+2RX1eFtlHXdrwH+IXDLQlHq6FJKCxeHmXRJf4lkiXFjzyp3HSm6WEZl93wQL
         44VlbOoWMI+Vj8SdwJXA8RKxMuoGH0NVGNXNrxnY+Ja/JKVZzWrSGTZumX7PrnHqVbdW
         KYyHlWUq/NIvxojR/Ns00EDg+ObvE7DaV9IAjfirO+z4F6CRBrdUk2zKVFwK9mitciEo
         41XeSxdEXXZivlhqAja8S/PB6RzsGKOV3UxJpsEm9RPmoM553JxHYUntrGUy7xS4ygbY
         hPtw==
X-Gm-Message-State: AOAM533iL8YrxSR+jUW0gaFhalhTfwFv3Ko3TegLtAqU5JKuGaSW1dnd
	RDBKGuCfuIQH17jCj7iCKcjvDQ==
X-Google-Smtp-Source: ABdhPJyPI7EORYAgVycLlQegnFv2rd20pMb2lVvSFF30VqlvxDOeWo1+I8FlJvkL88KcDDYEjDVixw==
X-Received: by 2002:a37:7a46:: with SMTP id v67mr1709338qkc.16.1611261754179;
        Thu, 21 Jan 2021 12:42:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b808])
        by smtp.gmail.com with ESMTPSA id c62sm4392313qkf.34.2021.01.21.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:42:33 -0800 (PST)
Date: Thu, 21 Jan 2021 15:42:31 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 1/4] mm: Introduce and use mapping_empty
Message-ID: <YAnnN1pnZAPse5X+@cmpxchg.org>
References: <20201026151849.24232-1-willy@infradead.org>
 <20201026151849.24232-2-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201026151849.24232-2-willy@infradead.org>
Message-ID-Hash: V6G7AM5BGZWIQ4VDAV5F4TMDZSVXG7SH
X-Message-ID-Hash: V6G7AM5BGZWIQ4VDAV5F4TMDZSVXG7SH
X-MailFrom: hannes@cmpxchg.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V6G7AM5BGZWIQ4VDAV5F4TMDZSVXG7SH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 26, 2020 at 03:18:46PM +0000, Matthew Wilcox (Oracle) wrote:
> Instead of checking the two counters (nrpages and nrexceptional), we
> can just check whether i_pages is empty.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Heh, I was looking for the fs/inode.c hunk here, because I remember
those BUG_ONs in the inode free path. Found it in the last patch - I
guess they escaped grep but the compiler let you know? :-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
