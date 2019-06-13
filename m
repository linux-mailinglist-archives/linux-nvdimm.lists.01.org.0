Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E268543246
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 05:00:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E22A21296070;
	Wed, 12 Jun 2019 20:00:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E2B3121296068
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 20:00:31 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j184so151683oih.1
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 20:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YtjHKeXC4gIvWD7qIGCgLw3Y5rasSRSWMaIKFvsdDLo=;
 b=Z8pBU4MM25/wj5R0MSgnE2EPofOlEtN2GXwgPgbMyok9GqUy7nHcXNH+xGB6LmT1ds
 oFAlrCARwn+KZmiDGhZsORABHwyYYpgWGD2z0mYN4HCjMyw6IlFzjKsLRhAGX19bRgnB
 jBYVkB9m7wd+GiGSDMD6A+OxtmgwTRLFxDzsXxx3SezFNwsiQ5JAvG5ZgiV7nRk3Cmuq
 khirjSp+wF9zavgenYpPzxsu4hqI5rrTwvkIuGZqjdzmKJa3u+iiGyemwNXooWty8Fa3
 Bv6VZE0RWMokXXovIf8jHh0nSRwZMF8x9nAaEz/29a7/iNnqdCPbA9Tuh3pqMIZkta0W
 qgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YtjHKeXC4gIvWD7qIGCgLw3Y5rasSRSWMaIKFvsdDLo=;
 b=rsrwqTbv4nK2GG/XMkwU1RrWcNomSp4qsLvPzR12mYpdBF/e57DTrtRZF8mpKMDn/n
 9umB2+D7kUgbJv77mx0Wcsdo7PYPVJeEJ00B/8kds+zN8jP9Fr72zXwS5EgLzDOAHd/6
 ffFqCwnznxR+9XVZphJnOboRQIPNWAKDws8mHgN6lgFMcx6nk8zHdBMHV4lytr1iRcah
 0OHjr8OrXT6gvVxU+jTC7DOnDNmt3dQ9WDToYEe/j+i2KXUcb/iD39FN3WNBsMx7dPn3
 HoBzFhJVKnopM3zzjyEy04uRZkE7y3urC3SD2HGXm0J5LbJI3+ns99oVSQ83TAn9taeX
 F62g==
X-Gm-Message-State: APjAAAW9o7iiilcb7g7ufndax47HTBHT9jH44HP18wr87VR/uABtrLF5
 dBdie+mqpIHdcr48NaSvhZsbuXBFLpOXVEAWlAqhnA==
X-Google-Smtp-Source: APXvYqxLQnntDWChlW5lUjbJdUNY/9pm0XYSXx35GpIfBrFOD5Lh4OxS2JEb0/NaJrEj5ME9HRrmcN4fRh+VmQGedXA=
X-Received: by 2002:aca:ed4c:: with SMTP id l73mr1572723oih.149.1560394830393; 
 Wed, 12 Jun 2019 20:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190612230845.GA13679@alison-desk.jf.intel.com>
 <CAPcyv4iF5cDoNB4e3GF0_HJRbxn+VWk=5QKuEk4wBWWn66AUvA@mail.gmail.com>
 <af2106d6b8f6380f59c6e26ba272abc8da5a7a73.camel@intel.com>
 <20190613014715.GA16728@alison-desk.jf.intel.com>
In-Reply-To: <20190613014715.GA16728@alison-desk.jf.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 12 Jun 2019 20:00:18 -0700
Message-ID: <CAPcyv4gpVHv+dc4Uqe6SCyZ2du1mAAq4SC8cy+xX0RSzcf8j1Q@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl, test: handle backup_keys in security.sh
To: Alison Schofield <alison.schofield@intel.com>
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
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 12, 2019 at 6:44 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Wed, Jun 12, 2019 at 04:26:16PM -0700, Verma, Vishal L wrote:
> >
> > On Wed, 2019-06-12 at 16:20 -0700, Dan Williams wrote:
> > > On Wed, Jun 12, 2019 at 4:05 PM Alison Schofield
> > > <alison.schofield@intel.com> wrote:
> > > > Fix a typo in security.sh that causes a script failure
> > > > when an nvdimm-master.blob already exists and needs to
> > > > be backed up.
> > > >
> > > > + setup_keys
> > > > + '[' '!' -d /etc/ndctl/keys ']'
> > > > + '[' -f /etc/ndctl/keys/nvdimm-master.blob ']'
> > > > + mv /etc/ndctl/keys/nvdimm-master.blob /etc/ndctl/keys/nvdimm-master.blob.bak
> > > > + 0=1
> > > > ./security.sh: line 39: 0=1: command not found
> > > >
> > > > Fixes: ba35642d3815 ("ndctl: add a load-keys test in the security unit test")
> > > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > > ---
> > > >  test/security.sh | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/test/security.sh b/test/security.sh
> > > > index 8a36265..c86d2c6 100755
> > > > --- a/test/security.sh
> > > > +++ b/test/security.sh
> > > > @@ -36,11 +36,11 @@ setup_keys()
> > > >
> > > >         if [ -f "$masterpath" ]; then
> > > >                 mv "$masterpath" "$masterpath.bak"
> > > > -               $backup_key=1
> > > > +               backup_key=1
> > > >         fi
> > > >         if [ -f "$keypath/tpm.handle" ]; then
> > > >                 mv "$keypath/tpm.handle" "$keypath/tmp.handle.bak"
> > > > -               $backup_handle=1
> > > > +               backup_handle=1
> > > >         fi
> > >
> > > Looks obviously correct to me.
> > >
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > ...but that said, why is this test even bothering with the host's
> > > configuration? I think it should be using a test local directory that
> > > does not disturb the rest of the system, especially because the test
> > > is using nfit_test resources.
>
> At first glance, it appears that the keys need to be in the
> {ndctl_keysdir}, aka, the official system location, for some
> of the ndctl commands to run. So, it's not as simple as just
> creating the key blob in a temp directory.

Currently, yes, but the typical way to override a build time
configuration is with an environment variable, similar to what we do
with NDCTL_TIMEOUT.

> And, I don't even think that's the nfit_test resource you are
> referring to anyway. I'll keep a look out for how it can run
> cleaner, and make it off the ENABLE_DESTRUCTIVE list in the future.

The test uses fake DIMMs from $NFIT_TEST_BUS0.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
