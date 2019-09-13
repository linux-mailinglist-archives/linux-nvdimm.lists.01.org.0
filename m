Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D717B22BE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 16:59:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A34F7202EA3E4;
	Fri, 13 Sep 2019 07:59:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=groeck7@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 33C6C2020D31A
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 07:59:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c17so7639897pgg.4
 for <linux-nvdimm@lists.01.org>; Fri, 13 Sep 2019 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fbWWNj6jxXYYNBiMWtbkbdqPv5Uo41BE2vW7jgQy9yM=;
 b=nIkoamXcdsZgqEDTMxSqZfXHWqb/2CXWw7STkZmWdv8GqMUcvweldqkTMGBQz104F3
 FO0h6Mfm2ALayhSV8nduPsSc/oNNmBiH0lZf3CYwWH9J5pIgJcKC7A1ERXtTwWfNM5vS
 W4uUY9OU2+vCEv3l+nsh91zBSCtT6QKyHoHhkL3OFo41L1wU1LSfge1JQM4yoRgpnLoh
 GWNZs67+6bb0jJTufFw1oiCeuhguIoFtgQvVBRjo11Jw8iKV1wTL+mNuHNFH/h5lT4Ph
 dlPXuyttHqMt17OcBfmaJ2gSnyJrUgnrttFsRn/IIw9ifrS8he6SBdcpWRgoPHx76W6r
 pvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=fbWWNj6jxXYYNBiMWtbkbdqPv5Uo41BE2vW7jgQy9yM=;
 b=HHhrO1613cDN1llpdDOy6ZpMwcVlPZSCGAUCb6GwqxXWl2aRU45TJecTiDc5Sp9KaW
 AyMM4rI3txQIvAwaIKwQNLu04r0xEhJ4MN+WnUcTcn/CiySAIsGRVpKyn2TDpVgrLAHp
 9rXPNHheelh6zRdQMszdqk+dB0P9pX4vZTeD4xutNGa8Xf9pJJfo0CvHMZeXfqrSiQGa
 pv5LehKDPPU9cfdkyUBkir0z/dy+Zce049g2EC71K7jdtcX/JLm10Nu60zQeAc1HS8qP
 jgRo2lCDx+wPU7PVdz5MgduiR1sJQjFoqCTM+nT2qC2v+Pen9vBpVHgR2SHRhbHYCLft
 9q7Q==
X-Gm-Message-State: APjAAAWEbuDErTbi9Xs0H9M2Vnkkn9JT4Uc8zqX7bCMIn+26DFzkau/B
 yW/FGIYqzXhgHXWAeF2u9iY=
X-Google-Smtp-Source: APXvYqw+hH/klJhUfGJZPpZyFTdzWL2P0k9B3pz/IyxTU+dkOaVThfbCWMZT0Twl9NzNad28EY13Kw==
X-Received: by 2002:a62:e21a:: with SMTP id a26mr57031115pfi.156.1568386753921; 
 Fri, 13 Sep 2019 07:59:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id s76sm27192710pgc.92.2019.09.13.07.59.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Sep 2019 07:59:12 -0700 (PDT)
Date: Fri, 13 Sep 2019 07:59:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
Message-ID: <20190913145911.GA21121@roeck-us.net>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com>
 <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
 <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
 <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
 <CAFhKne8Nbk=OnZO_pqPURneVtxcHqbfkH+xJBrAYfCfsntfQ2g@mail.gmail.com>
 <20190913105446.2b7af558@coco.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190913105446.2b7af558@coco.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 ksummit-discuss@lists.linuxfoundation.org, linux-nvdimm@lists.01.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Wilcox <willy6545@gmail.com>, linux-kernel@vger.kernel.org,
 Steve French <stfrench@microsoft.com>, Dmitry Vyukov <dvyukov@google.com>,
 "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Sep 13, 2019 at 10:54:46AM -0300, Mauro Carvalho Chehab wrote:
> Em Fri, 13 Sep 2019 08:56:30 -0400
> Matthew Wilcox <willy6545@gmail.com> escreveu:
> 
> > It's easy enough to move the kernel-doc warnings out from under W=1. I only
> > out them there to avoid overwhelming us with new warnings. If they're
> > mostly fixed now, let's make checking them the default.
> 
> Didn't try doing it kernelwide, but for media we do use W=1 by default,
> on our CI instance.
> 

I used to do that as well, but gave up on it since it resulted in lots
of warnings from generic kernel include files. I have not tried recently,
so maybe that is no longer the case.

> There's a few warnings at EDAC, but they all seem easy enough to be
> fixed.
> 

Acceptance depends on the maintainer, really. I had patches rejected
when trying to fix W=1 warnings, so I no longer do it.

> So, from my side, I'm all to make W=1 default.
> 
Seems to me that would require a common agreement that maintainers
are expected to accept fixes for problems reported with W=1.

Guenter

> Regards,
> Mauro
> 
> > 
> > On Thu., Sep. 12, 2019, 16:01 Bart Van Assche, <bvanassche@acm.org> wrote:
> > 
> > > On 9/12/19 8:34 AM, Joe Perches wrote:  
> > > > On Thu, 2019-09-12 at 14:31 +0100, Bart Van Assche wrote:  
> > > >> On 9/11/19 5:40 PM, Martin K. Petersen wrote:  
> > > >>> * The patch must compile without warnings (make C=1  
> > > CF="-D__CHECK_ENDIAN__")  
> > > >>>   and does not incur any zeroday test robot complaints.  
> > > >>
> > > >> How about adding W=1 to that make command?  
> > > >
> > > > That's rather too compiler version dependent and new
> > > > warnings frequently get introduced by new compiler versions.  
> > >
> > > I've never observed this myself. If a new compiler warning is added to
> > > gcc and if it produces warnings that are not useful for kernel code
> > > usually Linus or someone else is quick to suppress that warning.
> > >
> > > Another argument in favor of W=1 is that the formatting of kernel-doc
> > > headers is checked only if W=1 is passed to make.
> > >
> > > Bart.
> > >
> > > _______________________________________________
> > > Ksummit-discuss mailing list
> > > Ksummit-discuss@lists.linuxfoundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
> > >  
> 
> 
> 
> Thanks,
> Mauro
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
