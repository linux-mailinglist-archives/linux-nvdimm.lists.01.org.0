Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F012936FE
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Oct 2020 10:48:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AA72D15F1B908;
	Tue, 20 Oct 2020 01:48:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=john.haxby@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1E7AA15A38FA2;
	Tue, 20 Oct 2020 01:48:30 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09K8i7rI188082;
	Tue, 20 Oct 2020 08:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : message-id :
 content-type : mime-version : subject : date : in-reply-to : cc : to :
 references; s=corp-2020-01-29;
 bh=UBSvDuZX45rcdCwz1yIzvCzCqfd2joSCizhea4x+Xao=;
 b=q8gn83IPPWdFm1HT3taLhd9DUF/VTUU+yXtsd8f9nD6wriupB19ul4FsqzWGdtIZMcde
 GW+G9oeRVHaGmJfZ8muagtVwvuWLE6AywXuhak+OXkSgdFP6EIR2H2OqKDUhR7yIW2Vz
 zpamQMFlTWRfwdWHBA7I0p8HYGgPlEg7NOi5pNpKeOCI5/Zqu82RI3DyvlSb3YeNhNvu
 1nAbi2LxPOnr/RtC4QoVHdNGHfdCdQB+x9xvmqx+BqjtbEr8lrxt1aMjIali/bjhTn7W
 dzqjxrXdOv4FjsFo2kwRKNjQX5RScYby9/qqSUitUFXIKeMy4YBvXYVTZYkhax1TMfnU 0w==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 347s8msmp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2020 08:48:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09K8is45150623;
	Tue, 20 Oct 2020 08:48:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by userp3030.oracle.com with ESMTP id 348ahw07cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2020 08:48:12 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09K8mAEe159753;
	Tue, 20 Oct 2020 08:48:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3030.oracle.com with ESMTP id 348ahw07bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2020 08:48:10 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09K8lvTX021447;
	Tue, 20 Oct 2020 08:47:58 GMT
Received: from [10.175.164.120] (/10.175.164.120)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 20 Oct 2020 01:47:57 -0700
From: John Haxby <john.haxby@oracle.com>
Message-Id: <27A23102-A7F5-48C5-8972-48CE4C283C6E@oracle.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [Ocfs2-devel] [RFC] treewide: cleanup unreachable breaks
Date: Tue, 20 Oct 2020 09:47:45 +0100
In-Reply-To: <CAKwvOdkR_Ttfo7_JKUiZFVqr=Uh=4b05KCPCSuzwk=zaWtA2_Q@mail.gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
References: <20201017160928.12698-1-trix@redhat.com>
 <20201018054332.GB593954@kroah.com>
 <CAKwvOdkR_Ttfo7_JKUiZFVqr=Uh=4b05KCPCSuzwk=zaWtA2_Q@mail.gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1011 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200059
Message-ID-Hash: KT4RSHBIICZ2XRMKITA3LB4IU7EMZZPE
X-Message-ID-Hash: KT4RSHBIICZ2XRMKITA3LB4IU7EMZZPE
X-MailFrom: john.haxby@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Tom Rix <trix@redhat.com>, alsa-devel@alsa-project.org, clang-built-linux <clang-built-linux@googlegroups.com>, Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org, storagedev@microchip.com, dri-devel <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org, ath10k@lists.infradead.org, MPT-FusionLinux.pdl@broadcom.com, linux-stm32@st-md-mailman.stormreply.com, usb-storage@lists.one-eyed-alien.net, linux-watchdog@vger.kernel.org, devel@driverdev.osuosl.org, linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, linux-acpi@vger.kernel.org, intel-wired-lan@lists.osuosl.org, industrypack-devel@lists.sourceforge.net, linux-pci@vger.kernel.org, spice-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-serial@vger.kernel.org, linux-nfc@lists.01.org, linux-pm@vger
 .kernel.org, linux-can@vger.kernel.org, linux-block@vger.kernel.org, linux-gpio@vger.kernel.org, xen-devel@lists.xenproject.org, linux-amlogic@lists.infradead.org, openipmi-developer@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, linux-integrity@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-edac@vger.kernel.org, George Burgess <gbiv@google.com>, Network Development <netdev@vger.kernel.org>, linux-usb@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, patches@opensource.cirrus.com, bpf <bpf@vger.kernel.org>, ocfs2-devel@oss.oracle.com, linux-power@fi.rohmeurope.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KT4RSHBIICZ2XRMKITA3LB4IU7EMZZPE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============3123267047470561446=="


--===============3123267047470561446==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_9F9749E9-79EA-41AB-B516-003ECE07BEE3";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_9F9749E9-79EA-41AB-B516-003ECE07BEE3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 19 Oct 2020, at 20:42, Nick Desaulniers <ndesaulniers@google.com> =
wrote:
>=20
> We probably should add all 3 to W=3D2 builds (wrapped in cc-option).
> I've filed https://github.com/ClangBuiltLinux/linux/issues/1180 to
> follow up on.

It looks as though the URL mangling has been fixed.   If anyone sees =
that specific URL mangled, please let me know.

jch

--Apple-Mail=_9F9749E9-79EA-41AB-B516-003ECE07BEE3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iHUEAREIAB0WIQT+pxvb11CFWUkNSOVFC7t+lC+jyAUCX46kMQAKCRBFC7t+lC+j
yBKiAP90JVXdPzuAwtRGkROpw1eVCo7wCaZ5nOa8Oo0sN6gC9gD/S0eGTqQhmg+n
sXPJxPYqQsg09qmS6k/HX+AP5Oz2AMo=
=xx66
-----END PGP SIGNATURE-----

--Apple-Mail=_9F9749E9-79EA-41AB-B516-003ECE07BEE3--

--===============3123267047470561446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============3123267047470561446==--
