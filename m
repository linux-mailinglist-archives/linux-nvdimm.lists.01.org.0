Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA5543218
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 03:44:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0AED721296066;
	Wed, 12 Jun 2019 18:44:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=alison.schofield@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AE6382194EB77
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 18:44:03 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jun 2019 18:44:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,367,1557212400"; d="scan'208";a="184440922"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
 by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2019 18:44:02 -0700
Date: Wed, 12 Jun 2019 18:47:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH] ndctl, test: handle backup_keys in security.sh
Message-ID: <20190613014715.GA16728@alison-desk.jf.intel.com>
References: <20190612230845.GA13679@alison-desk.jf.intel.com>
 <CAPcyv4iF5cDoNB4e3GF0_HJRbxn+VWk=5QKuEk4wBWWn66AUvA@mail.gmail.com>
 <af2106d6b8f6380f59c6e26ba272abc8da5a7a73.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <af2106d6b8f6380f59c6e26ba272abc8da5a7a73.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Wed, Jun 12, 2019 at 04:26:16PM -0700, Verma, Vishal L wrote:
> 
> On Wed, 2019-06-12 at 16:20 -0700, Dan Williams wrote:
> > On Wed, Jun 12, 2019 at 4:05 PM Alison Schofield
> > <alison.schofield@intel.com> wrote:
> > > Fix a typo in security.sh that causes a script failure
> > > when an nvdimm-master.blob already exists and needs to
> > > be backed up.
> > > 
> > > + setup_keys
> > > + '[' '!' -d /etc/ndctl/keys ']'
> > > + '[' -f /etc/ndctl/keys/nvdimm-master.blob ']'
> > > + mv /etc/ndctl/keys/nvdimm-master.blob /etc/ndctl/keys/nvdimm-master.blob.bak
> > > + 0=1
> > > ./security.sh: line 39: 0=1: command not found
> > > 
> > > Fixes: ba35642d3815 ("ndctl: add a load-keys test in the security unit test")
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  test/security.sh | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/test/security.sh b/test/security.sh
> > > index 8a36265..c86d2c6 100755
> > > --- a/test/security.sh
> > > +++ b/test/security.sh
> > > @@ -36,11 +36,11 @@ setup_keys()
> > > 
> > >         if [ -f "$masterpath" ]; then
> > >                 mv "$masterpath" "$masterpath.bak"
> > > -               $backup_key=1
> > > +               backup_key=1
> > >         fi
> > >         if [ -f "$keypath/tpm.handle" ]; then
> > >                 mv "$keypath/tpm.handle" "$keypath/tmp.handle.bak"
> > > -               $backup_handle=1
> > > +               backup_handle=1
> > >         fi
> > 
> > Looks obviously correct to me.
> > 
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > ...but that said, why is this test even bothering with the host's
> > configuration? I think it should be using a test local directory that
> > does not disturb the rest of the system, especially because the test
> > is using nfit_test resources.

At first glance, it appears that the keys need to be in the
{ndctl_keysdir}, aka, the official system location, for some
of the ndctl commands to run. So, it's not as simple as just
creating the key blob in a temp directory.

And, I don't even think that's the nfit_test resource you are
referring to anyway. I'll keep a look out for how it can run
cleaner, and make it off the ENABLE_DESTRUCTIVE list in the future.

> > 
> > There's no guarantee that the script successfully reaches the
> > post_cleanup() phase to restore the host configuration and could leave
> > it broken. Unless / until we can fix up this test to not touch /etc I
> > think it should be moved to the ENABLE_DESTRUCTIVE set of tests.
> 
> Hm, yes good point. I agree with moving it to destructive for now.
Vishal, Do you need a patch that moves it to the naughty list?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
