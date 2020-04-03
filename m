Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3358719CDEB
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 02:50:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 001571010919E;
	Thu,  2 Apr 2020 17:51:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 11D4A1010919B
	for <linux-nvdimm@lists.01.org>; Thu,  2 Apr 2020 17:50:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id de14so7073580edb.4
        for <linux-nvdimm@lists.01.org>; Thu, 02 Apr 2020 17:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dUEYZjWWMHJXst4WV8j9nCyjHYIXBDcN6VSpUw0gbVM=;
        b=baZTVQAnqXrBYnPvbXACvucvZIqe3nb211Ui8JkJb0UkViSzAmrwCJVFgAThAA7LUq
         TYxNyqG1d5Ax04ruNlBPKhd8lngk95Ttq89x96XPiX6WWNIBLSXgLSaOfos7WTAN25Ob
         akiflooGILFKGYq2Dy2bjY4PsFYJqIa96MQ/Ans8NRaUbjvUCJyQTvALe2eOTyh1OaUL
         UI9HiZUMObenTvz03XA2DjIor7zKcpDEM92HJMgXNZnMK09gX/hw1eFFkVvfvGwbmeUo
         udAmMPnRhTCfHED0pm0jOoF7PoRI6329FseRgegybGeV9GvlzHgndbtgR0bOgeo7jnGf
         ztug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dUEYZjWWMHJXst4WV8j9nCyjHYIXBDcN6VSpUw0gbVM=;
        b=g8uEJco7vBJNDXQLGzIRYdsg0AZJO3dXG6Kzy9XgYFZ4fCdRg1Ji3/olqWvOadIPd2
         xBULvqqljthnk0a5YY8pvI83afn+5mFF9ospJojyPLRV0epqlTHMzpZ8YP/dqOJ7PFCj
         xjWs3CYBmujujYbtV/K4fDZd/HS531PHJxfQs6BWBRJcrXk2AblbatDf6/dZ1znvV9jj
         D0rGMj48TGABXMzvPJ3YPf7rIX9VwaTRVVhhY0N2pjjcZ/8s0OxHT9J49c7RK4/j/gt1
         s9tivYO3k9DvWWl4RkFOAdyXrVTUushayP0UJBk9nf2tLRUXZNkLbgdcVPTjJVeLkHQ0
         ZCgw==
X-Gm-Message-State: AGi0PuZYkeZ/tohz3h8jXKtf1JQggPgZrMlPzwSaq7Zn4ESV5ilxAC94
	28/Xo3TypwhUBcbmCKsg8dtprJmJe8sd2VRxf3mKPA==
X-Google-Smtp-Source: APiQypKk0+do2txTWB61ucVZLOkss2cjeqGQGndVxlcxXmIo/3Jb4DnDa+Nd/nrjffQoH5hYIo7FhAXp030eLnr8+iU=
X-Received: by 2002:a05:6402:b17:: with SMTP id bm23mr5520314edb.165.1585875007220;
 Thu, 02 Apr 2020 17:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200228163456.1587-1-vgoyal@redhat.com> <20200228163456.1587-5-vgoyal@redhat.com>
 <CAPcyv4iWfL+KQjjUXqrTKOL8F4M05Vu=imm5tqsD6MO=XLzoMA@mail.gmail.com>
In-Reply-To: <CAPcyv4iWfL+KQjjUXqrTKOL8F4M05Vu=imm5tqsD6MO=XLzoMA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 2 Apr 2020 17:49:56 -0700
Message-ID: <CAPcyv4h=xQRPBwfy6xMjUONk41aO0xBYHpu9auSHdG17CWdv=g@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] dm,dax: Add dax zero_page_range operation
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: FI7FGBRPIFITIOIYRDEMK5H3ALAF5STA
X-Message-ID-Hash: FI7FGBRPIFITIOIYRDEMK5H3ALAF5STA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, david <david@fromorbit.com>, device-mapper development <dm-devel@redhat.com>, Mike Snitzer <msnitzer@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FI7FGBRPIFITIOIYRDEMK5H3ALAF5STA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 31, 2020 at 12:34 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> [ Add Mike ]
>
> On Fri, Feb 28, 2020 at 8:35 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > This patch adds support for dax zero_page_range operation to dm targets.
>
> Mike,
>
> Sorry, I should have pinged you earlier, but could you take a look at
> this patch and ack it if it looks ok to go through the nvdimm tree
> with the rest of the series?

I'm going to proceed with pushing this into -next to get more exposure
and check back later next week about pushing it to Linus. It looks
good to me and it unblocks Vivek on his virtio-fs work, but still
don't want to push device-mapper bits without device-mapper maintainer
Ack.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
