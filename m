Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 268B42FF640
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 21:46:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0BB46100F2254;
	Thu, 21 Jan 2021 12:46:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com; envelope-from=hannes@cmpxchg.org; receiver=<UNKNOWN> 
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7CBF7100F2253
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 12:46:51 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id q9so2756440qkn.2
        for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 12:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GGUNk7vhkO0IoLRkb7NZj4Pj5vz/6dqRquEfQAmHYUo=;
        b=UGkBP8zne2UEhx8nSu1JlsPoUjs0tG8DW1Qr4aSAP8Lzp0Qec6gE9yxpwYFJ2UIiFX
         C4/UC02W6/1ffmpRc2gsRvjxRvRsCZ1vVNQiIjuoR3yDs1sdoMe5SovJE67eHZYlHKmc
         c9+OAxsgsWofKUqz1i0LU0oiIlQFrNPuClaTcONcH5gD5WowAOzVdvDAe7ZYjDYkyATp
         kMSlMAjaAjVnCPqiqKZDuVPZtvq7/O06Wd6bzbr6rqqJLkPK0VTHHe2i56umZeYXGelD
         fh0wrueli+xxzXNKU9irVOOT4BC/7xo3n8GtYxPTNhlb63NzsNJFNQtNa8OXT6CZRiKS
         Yj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GGUNk7vhkO0IoLRkb7NZj4Pj5vz/6dqRquEfQAmHYUo=;
        b=Vk4cgahsYFRX/xr04we2HlOL7d0If4XhMDpg4g29swV0hAjLwYoGt2NQLWLaHbFRRN
         LRjk7zjE9Dc6qfwsjRRW/U1NzjBxuUXvB2Q+/AxAmpaN//UG8DJ/FYwpNwotAkZJ5g0/
         MKQwwc7LaIVIf0ExLOSTqo3GT0H6b9+KYaB4JwB7WiJqwvprL4T/JC97yrwJF4r0O8Mi
         29Mz8e5V29w7YSkg1C+oITvDGjnmmU+8QCesnX+cKmh74q6XZYcIokd14YYJ9KcN9q53
         /cXD8EwLp8aBSa0m6e5dRg9st/fg3AB0WVmp/0zUZvZRnk9zJZY4K+yQVGCcBmhx62N2
         6xUA==
X-Gm-Message-State: AOAM530zhWPxvvLAtvMlPKTV7biEycP95NVOeSkKpge7HWF68E6kEXm9
	PDySn4nsDOEfpAkGw7owzaMGnQ==
X-Google-Smtp-Source: ABdhPJwApGK4RaZq2SOhZ3wOfS6eZhO8xnmttG6vEStqJ7SwbpY/ZTeImS7T3AoCQ4VJUOSUngTuJw==
X-Received: by 2002:a05:620a:805:: with SMTP id s5mr1761345qks.80.1611262010398;
        Thu, 21 Jan 2021 12:46:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b808])
        by smtp.gmail.com with ESMTPSA id 16sm4648862qkf.112.2021.01.21.12.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:46:49 -0800 (PST)
Date: Thu, 21 Jan 2021 15:46:48 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 3/4] dax: Account DAX entries as nrpages
Message-ID: <YAnoOHMMsc/q+lH+@cmpxchg.org>
References: <20201026151849.24232-1-willy@infradead.org>
 <20201026151849.24232-4-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201026151849.24232-4-willy@infradead.org>
Message-ID-Hash: KFNUCLVEJZF6XDFMTBP26Z34VL6MO4OD
X-Message-ID-Hash: KFNUCLVEJZF6XDFMTBP26Z34VL6MO4OD
X-MailFrom: hannes@cmpxchg.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KFNUCLVEJZF6XDFMTBP26Z34VL6MO4OD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 26, 2020 at 03:18:48PM +0000, Matthew Wilcox (Oracle) wrote:
> Simplify mapping_needs_writeback() by accounting DAX entries as
> pages instead of exceptional entries.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
