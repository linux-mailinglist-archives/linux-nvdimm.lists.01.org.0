Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565AA0B55
	for <lists+linux-nvdimm@lfdr.de>; Wed, 28 Aug 2019 22:25:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67A2220215F61;
	Wed, 28 Aug 2019 13:27:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=keescook@chromium.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CE5EF20212CBF
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 13:27:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b24so525256pfp.1
 for <linux-nvdimm@lists.01.org>; Wed, 28 Aug 2019 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=m9K6geHQslN19tGBbmOQDx2FY+2m9BB3O5M0ryJqK9c=;
 b=bx1zz6Bghmx2cAm/3B3M1XQ5TzD9T6Shao6YQ/kAskDAzddvVphm3y/VszXyU8cVxt
 GmrZL8kV6W5wHbTkcTKkqgx5rPnKlOZTZtpFqe0b87i6tjcwzIPvhnmQatdzfwt755AQ
 /TbGEuYOWia2rpi1xfmsUoZAgfgNRQN8izYhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m9K6geHQslN19tGBbmOQDx2FY+2m9BB3O5M0ryJqK9c=;
 b=c/5LxDcCRVLlx5FfGJfgWjrI+z94UTmgJdrRqobw/hZhLGg34kprRpUQIBhkpZe/2l
 1kEemYPj6PD4jxfiU8rzwuBw3aW0FlyeQ7t4DzOiMkbyUlnJ5vTV0CBJl9jprGHi17ld
 7RjSsGuyFECE8WO3Dopyvv3NzBNvKGekhgR+TytWH3UwEUTOd27ZAu+cn+Nc4WU08xLX
 ALkhifH9kKg07OrBeF2CJ617ZJhxP8zoWxa6Uq9tybKAessKEg8cYrqOt8vtG92ujtbT
 BFm6JZtLnnY7WWRnYt6wasRPre0aeXZfLiT0itOqldrcS+zKaIi6oQ4xhIy61Ptglx18
 UmaQ==
X-Gm-Message-State: APjAAAVOSIJNX86423mOqeOTzjZNESpdthZrOJ4Wl1yztDDWLFYgNsdL
 bZyuk6pDZgIqvTdgp33ptCEBog==
X-Google-Smtp-Source: APXvYqxQAENVpZgVbOZciL3QGjuq0yBD38cfywqNfv+zc8DilopsyfnAC3fYr1sECkiUbk2gzmgRoA==
X-Received: by 2002:a63:5a0a:: with SMTP id o10mr5112466pgb.282.1567023932990; 
 Wed, 28 Aug 2019 13:25:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id h17sm232891pfo.24.2019.08.28.13.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 13:25:32 -0700 (PDT)
Date: Wed, 28 Aug 2019 13:25:31 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] libnvdimm, region: Use struct_size() in kzalloc()
Message-ID: <201908281325.1E7C2A9@keescook>
References: <20190610210613.GA21989@embeddedor>
 <3abfb317-76cc-f9a0-243f-9b493a524a98@embeddedor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3abfb317-76cc-f9a0-243f-9b493a524a98@embeddedor.com>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 28, 2019 at 01:30:24PM -0500, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping:
> 
> Who can take this, please?
> 
> Thanks
> --
> Gustavo
> 
> On 6/10/19 4:06 PM, Gustavo A. R. Silva wrote:
> > One of the more common cases of allocation size calculations is finding
> > the size of a structure that has a zero-sized array at the end, along
> > with memory for some number of elements for that array. For example:
> > 
> > struct nd_region {
> > 	...
> >         struct nd_mapping mapping[0];
> > };
> > 
> > instance = kzalloc(sizeof(struct nd_region) + sizeof(struct nd_mapping) *
> >                           count, GFP_KERNEL);
> > 
> > Instead of leaving these open-coded and prone to type mistakes, we can
> > now use the new struct_size() helper:
> > 
> > instance = kzalloc(struct_size(instance, mapping, count), GFP_KERNEL);
> > 
> > This code was detected with the help of Coccinelle.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

FWIW,

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> > ---
> >  drivers/nvdimm/region_devs.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> > index b4ef7d9ff22e..88becc87e234 100644
> > --- a/drivers/nvdimm/region_devs.c
> > +++ b/drivers/nvdimm/region_devs.c
> > @@ -1027,10 +1027,9 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
> >  		}
> >  		region_buf = ndbr;
> >  	} else {
> > -		nd_region = kzalloc(sizeof(struct nd_region)
> > -				+ sizeof(struct nd_mapping)
> > -				* ndr_desc->num_mappings,
> > -				GFP_KERNEL);
> > +		nd_region = kzalloc(struct_size(nd_region, mapping,
> > +						ndr_desc->num_mappings),
> > +				    GFP_KERNEL);
> >  		region_buf = nd_region;
> >  	}
> >  
> > 

-- 
Kees Cook


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
